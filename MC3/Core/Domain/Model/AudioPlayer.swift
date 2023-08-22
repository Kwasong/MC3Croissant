import AVFoundation

class AudioPlayer: NSObject, ObservableObject, AVAudioPlayerDelegate {
    private var player: AVAudioPlayer?
    private var bgmPlayer: AVAudioPlayer?
    
    private var timer: Timer?
    // Published properties to notify the ViewModel and View
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0.0
    @Published var duration: TimeInterval = 0.0
    @Published var isRepeatOn: Bool = false
    @Published var didFinishedPlaying = false
    
    //MARK: common setup
    
    private func setupPlayer(url: URL, volume: Float, fadeDuration: TimeInterval = 0) throws -> AVAudioPlayer {
        let audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.setVolume(volume, fadeDuration: fadeDuration)
        duration = audioPlayer.duration
        return audioPlayer
    }
    
    private func setupPlayer(data: Data, volume: Float, fadeDuration: TimeInterval = 0) throws -> AVAudioPlayer {
        let audioPlayer = try AVAudioPlayer(data: data)
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.setVolume(volume, fadeDuration: fadeDuration)
        duration = audioPlayer.duration
        return audioPlayer
    }
    
    //MARK: playback function
    
    private func play(player: AVAudioPlayer?) {
        player?.play()
    }
    
    private func stop(player: AVAudioPlayer?) {
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }
        player.stop()
        player.currentTime = 0
    }
    
    private func pause(player: AVAudioPlayer?) {
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }
        player.pause()
    }
    
    //MARK: - Audio Playback
    
    func playBgm(track: String, withExtension: String = "mp3", volume: Float = 20) {
        guard let url = Bundle.main.url(forResource: track, withExtension: withExtension) else {
            print("Resource not found: \(track)")
            return
        }
        
        do {
            bgmPlayer = try setupPlayer(url: url, volume: volume)
            play(player: bgmPlayer)
        } catch {
            print("Error playing background audio: \(error.localizedDescription)")
        }
    }
    
    func prepareAudio(track: String, withExtension: String = "mp3", volume: Float = 30) {
        guard let url = Bundle.main.url(forResource: track, withExtension: withExtension) else {
            print("Resource not found: \(track)")
            return
        }
        
        do {
            player = try setupPlayer(url: url, volume: volume)
        } catch {
            print("Error preparing audio: \(error.localizedDescription)")
        }
    }
    
    func playFromData(track: Data, volume: Float = 40) {
        do {
            player = try setupPlayer(data: track, volume: volume)
            play(player: player)
        } catch {
            print("Error preparing audio: \(error.localizedDescription)")
        }
    }
    
    //MARK: Playback Controls
    
    func resumeAudio() {
        duration = player?.duration ?? 0.0
        play(player: player)
        isPlaying = true
    }
    
    func pauseAudio(){
        pause(player: player)
        isPlaying = false
    }
    
    func stopAudio() {
        stop(player: player)
        isPlaying = false
    }
    
    func stopBgm() {
        stop(player: bgmPlayer)
        isPlaying = false
    }
    
    func toggleRepeat() {
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }
        isRepeatOn.toggle()
        player.numberOfLoops = isRepeatOn ? -1 : 0
        print(player.numberOfLoops)
    }
    
    //MARK: - AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
        if !isRepeatOn {
            didFinishedPlaying = true
        }
        currentTime = 0
    }
    
    func reset() {
        guard let player = player else {
            print("Instance of audio player not found")
            return
        }
        pause(player: player)
        player.currentTime = 0
        currentTime = 0
        isRepeatOn = false
    }
}
