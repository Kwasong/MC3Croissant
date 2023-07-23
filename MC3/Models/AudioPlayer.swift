import AVFoundation

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    private var player: AVAudioPlayer?
    private var timer: Timer?
    
    // Published properties to notify the ViewModel and View
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0.0
    @Published var duration: TimeInterval = 0.0
    @Published var isRepeatOn: Bool = false
    
    func prepareAudio(track: String, withExtension: String = "mp3", isPreview: Bool = false){
        guard let url = Bundle.main.url(forResource: track, withExtension: withExtension) else {
            print("Resource not found: \(track)")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.delegate = self
            player?.prepareToPlay()
            duration = player?.duration ?? 0.0
        } catch {
            print("Error preparing audio: \(error.localizedDescription)")
        }
    }
    
    // Function to pause audio
    func pauseAudio() {
        player?.pause()
        isPlaying = false
        stopTimer()
    }
    
    // Function to resume audio playback
    func resumeAudio() {
        duration = player?.duration ?? 0.0
        player?.play()
        isPlaying = true
        startTimer()
    }
    
    func stopAudio() {
        player?.stop()
        player?.currentTime = 0
        isPlaying = false
        stopTimer()
    }
    
    // Function to seek forward by a given number of seconds
    func seekForward(seconds: TimeInterval) {
        let time = min(player?.currentTime ?? 0 + seconds, duration)
        player?.currentTime = time
        currentTime = time
    }
    
    // Function to seek backward by a given number of seconds
    func seekBackward(seconds: TimeInterval) {
        let time = max(player?.currentTime ?? 0 - seconds, 0)
        player?.currentTime = time
        currentTime = time
    }
    
    // Function to toggle repeat mode
    func toggleRepeat() {
        isRepeatOn.toggle()
        player?.numberOfLoops = isRepeatOn ? -1 : 0
    }
    
    // Function to start the timer for updating the current time
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            self.updateTime()
        }
    }
    
    // Function to stop the timer
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    // Function to update the current time during playback
    private func updateTime() {
        currentTime = player?.currentTime ?? 0
    }
    
    // AVAudioPlayerDelegate method called when audio finishes playing
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        currentTime = 0
        stopTimer()
    }
    
}
