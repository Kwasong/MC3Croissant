import SwiftUI
import Speech

struct SpeechToTextView: View {
    @State private var isRecording = false
    @State private var recognizedText = ""
    @State private var audioEngine: AVAudioEngine?
    @State private var speechRecognizer: SFSpeechRecognizer?
    @State private var request: SFSpeechAudioBufferRecognitionRequest?
    @State private var recognitionTask: SFSpeechRecognitionTask?
    @State private var silenceTimer: Timer?

    var body: some View {
        VStack {
            Text(recognizedText)
                .padding()

            Button(action: {
                if self.isRecording {
                    self.stopRecording()
                } else {
                    self.startRecording()
                }
            }) {
                Text(self.isRecording ? "Stop Recording" : "Start Recording")
                    .padding()
                    .background(self.isRecording ? Color.red : Color.green)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }

    private func startRecording() {
        guard let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-EN")), speechRecognizer.isAvailable else {
            print("Speech recognition not available")
            return
        }

        self.isRecording = true
        self.recognizedText = "Listening..."

        // Set up the audio engine and recognition request
        self.audioEngine = AVAudioEngine()
        self.request = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = self.request else {
            print("Unable to create an audio buffer recognition request")
            return
        }

        recognitionRequest.shouldReportPartialResults = true
        recognitionRequest.taskHint = .dictation

        let inputNode = self.audioEngine!.inputNode
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            recognitionRequest.append(buffer)
        }

        self.audioEngine!.prepare()

        do {
            try self.audioEngine!.start()
        } catch {
            print("Audio engine failed to start: \(error.localizedDescription)")
        }

        self.recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            if let result = result {
                self.recognizedText = result.bestTranscription.formattedString
                self.checkSpeechActivity(result.isFinal)
            } else if let error = error {
                print("Recognition task error: \(error.localizedDescription)")
            }
        }

        // Start the silence timer
        self.silenceTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
            if self.isRecording {
                // The timer has fired, indicating 2 seconds of silence.
                // You can perform any action here when the user has been silent for 2 seconds.
                print("User has been silent for more than 2 seconds")
                self.stopRecording()
            }
        }
    }

    private func stopRecording() {
        self.audioEngine?.stop()
        self.request?.endAudio()
        self.recognitionTask?.cancel()
        self.isRecording = false

        // Invalidate the silence timer when stopping the recording
        self.silenceTimer?.invalidate()
    }

    private func checkSpeechActivity(_ isFinal: Bool) {
        // Perform any action or check you want to do when speech is finished (isFinal == true)
        if isFinal {
            print("Speech is finished")
        } else {
            // Restart the silence timer if speech activity is detected
            self.silenceTimer?.invalidate()
            self.silenceTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                if self.isRecording {
                    // The timer has fired, indicating 2 seconds of silence.
                    // You can perform any action here when the user has been silent for 2 seconds.
                    print("User has been silent for more than 2 seconds")
                    self.stopRecording()
                }
            }
        }
    }
}

struct SpeechToTextView_Previews: PreviewProvider {
    static var previews: some View {
        SpeechToTextView()
    }
}
