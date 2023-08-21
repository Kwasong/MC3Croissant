import Combine
import AVFoundation

class MusicViewModel: ObservableObject {
    
    private var audioPlayer: AudioPlayer = AudioPlayer()
    
    // Expose @Published properties from the AudioPlayer to update the View
    @Published var isPlaying: Bool = false {
        didSet {
            // Perform any additional actions when isPlaying changes if needed
        }
    }
    
    @Published var currentTime: TimeInterval = 0.0 {
        didSet {
            // Perform any additional actions when currentTime changes if needed
        }
    }
    
    @Published var duration: TimeInterval = 0.0 {
        didSet {
            // Perform any additional actions when duration changes if needed
        }
    }
    
    @Published var isRepeatOn: Bool = false {
        didSet {
            // Perform any additional actions when isRepeatOn changes if needed
            audioPlayer.toggleRepeat()
        }
    }
    
    init() {
        // Set up bindings to update ViewModel properties from the AudioPlayer
        self.audioPlayer.$isPlaying.assign(to: &$isPlaying)
        self.audioPlayer.$currentTime.assign(to: &$currentTime)
        self.audioPlayer.$duration.assign(to: &$duration)
        self.audioPlayer.$isRepeatOn.assign(to: &$isRepeatOn)
    }
    
    // Implement other methods to control the audio player using AudioPlayer instance
    func prepareAudio(track: String, withExtension: String = "mp3", isPreview: Bool = false) {
        audioPlayer.prepareAudio(track: track, withExtension: withExtension, isPreview: isPreview)
    }
    
    func playAudio() {
        audioPlayer.resumeAudio()
    }
    func pauseAudio() {
        audioPlayer.pauseAudio()
    }

    func resumeAudio() {
        audioPlayer.resumeAudio()
    }

    func seekForward(seconds: TimeInterval) {
        audioPlayer.seekForward(seconds: seconds)
    }

    func seekBackward(seconds: TimeInterval) {
        audioPlayer.seekBackward(seconds: seconds)
    }
    
    func stopAudio(){
        audioPlayer.stopAudio()
    }
}
