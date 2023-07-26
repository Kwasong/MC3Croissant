import AVFoundation

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    private var player: AVAudioPlayer?
    private var timer: Timer?
    
    // Published properties to notify the ViewModel and View
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0.0
    @Published var duration: TimeInterval = 0.0
    @Published var isRepeatOn: Bool = false
    @Published var didFinishedPlaying = false
    
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
            player?.setVolume(100, fadeDuration: 0)
            
            duration = player?.duration ?? 0.0
            
        } catch {
            print("Error preparing audio: \(error.localizedDescription)")
        }
    }
    
    
    
    func playFromData(track: Data){
        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
//            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(data: track)
            player?.delegate = self
            player?.prepareToPlay()
            
            duration = player?.duration ?? 0.0
            
        } catch {
            print("Error preparing audio: \(error.localizedDescription)")
        }
    }
    
    // Function to pause audio
    func pauseAudio() {
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }
        player.pause()
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
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }
        player.stop()
        player.currentTime = 0
        isPlaying = false
        stopTimer()
    }
    
    // Function to toggle repeat mode
    func toggleRepeat() {
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }
        isRepeatOn.toggle()
        player.numberOfLoops = isRepeatOn ? -1 : 0
        print(player.numberOfLoops)
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
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }
        currentTime = player.currentTime
    }
    
    // AVAudioPlayerDelegate method called when audio finishes playing
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        if !isRepeatOn{
            didFinishedPlaying = true
        }
        currentTime = 0
        stopTimer()
    }
    
    func reset() {
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }
        pauseAudio()
        player.currentTime = 0
        currentTime = 0
        isRepeatOn = false
    }
    
}
