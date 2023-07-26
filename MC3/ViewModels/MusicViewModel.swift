import Combine
import SwiftUI
import AVFoundation

class MusicViewModel: ObservableObject {
    @Published var albums: [Album] = []
    @Published var selectedAlbum: Album?
    @Published var soundIndex: Int = 0
    @Published var navigateToNextView: Bool = false
    
    
    private var audioPlayer: AudioPlayer = AudioPlayer()
    @Published var isPlaying: Bool = false
    @Published var currentTime: TimeInterval = 0.0
    @Published var duration: TimeInterval = 0.0
    @Published var isRepeatOn: Bool = false
    @Published var didFinishedPlaying: Bool = false
    @Published var isOnShuffle: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.albums = Album.mockAlbums
        if let firstAlbum = albums.first {
            print("get first album")
            self.selectedAlbum = firstAlbum
            
        }
        
        // Set up bindings to update ViewModel properties from the AudioPlayer
        self.audioPlayer.$isPlaying.assign(to: &$isPlaying)
        self.audioPlayer.$currentTime.assign(to: &$currentTime)
        self.audioPlayer.$duration.assign(to: &$duration)
        self.audioPlayer.$isRepeatOn.assign(to: &$isRepeatOn)
        self.audioPlayer.$didFinishedPlaying.assign(to: &$didFinishedPlaying)
        
        
        audioPlayer.$didFinishedPlaying
            .sink { [weak self] didFinishedPlaying in
                guard let self = self else {return}
                
                if isRepeatOn {
                    return
                }
                if didFinishedPlaying {
                    // The song has finished playing.
                    // You can perform any actions needed here.
                    // For example, play the next song, show a message, etc.
                    self.handleSongFinishedPlaying()
                }
            }
            .store(in: &cancellables)
    }
    
    private func generateUniqueRandomNumbers(count: Int, range: ClosedRange<Int>) -> [Int] {
        var numbers = Array(range)
        var randomNumbers: [Int] = []
        
        for _ in 0..<min(count, numbers.count) {
            let randomIndex = Int.random(in: 0..<numbers.count)
            let randomNumber = numbers[randomIndex]
            numbers.remove(at: randomIndex)
            randomNumbers.append(randomNumber)
        }
        
        return randomNumbers
    }
    
    // Implement other methods to control the audio player using AudioPlayer instance
    
    func prepareAudio(track: String, withExtension: String = "mp3", isPreview: Bool = false) {
        audioPlayer.prepareAudio(track: track, withExtension: withExtension, isPreview: isPreview)
    }
    
    func playAudio() {
        audioPlayer.didFinishedPlaying = false
        audioPlayer.resumeAudio()
    }
    func pauseAudio() {
        audioPlayer.pauseAudio()
    }
    
    func resumeAudio() {
        audioPlayer.resumeAudio()
    }
    
    
    func stopAudio(){
        audioPlayer.stopAudio()
    }
    
    private func generateRandomIndex(count: Int, currentIndex: Int)-> Int{
        var shuffledIndices = Array(0..<count)
        shuffledIndices.shuffle()
        
        return shuffledIndices.first(where: { $0 != currentIndex }) ?? 0
        
    }
    
    func playNextSound() {
        audioPlayer.stopAudio()
        if isOnShuffle {
            soundIndex = generateRandomIndex(count: selectedAlbum!.sounds.count, currentIndex: soundIndex)
            
            prepareAudio(track: (selectedAlbum?.sounds [soundIndex].soundPath)!)
            playAudio()
        }else {
            if isNextSoundExist() {
                soundIndex += 1
                prepareAudio(track: (selectedAlbum?.sounds [soundIndex].soundPath)!)
                playAudio()
            }
        }
        
        
        
    }
    
    
    func playPreviousSound(){
        audioPlayer.stopAudio()
        if isOnShuffle {
            soundIndex = generateRandomIndex(count: selectedAlbum!.sounds.count, currentIndex: soundIndex)
            prepareAudio(track: (selectedAlbum?.sounds [soundIndex].soundPath)!)
            playAudio()
        }else {
            if isPrevSoundExist() {
                soundIndex -= 1
                
                prepareAudio(track: (selectedAlbum?.sounds [soundIndex].soundPath)!)
                playAudio()
            }
        }
        
    }
    
    func isPrevSoundExist() -> Bool {
        guard let sounds = selectedAlbum?.sounds else {return false}
        
        if soundIndex != 0 {
            return true
        }
        
        return false
    }
    
    func isNextSoundExist() -> Bool {
        guard let sounds = selectedAlbum?.sounds else {return false}
        
        if soundIndex != sounds.count - 1 {
            return true
        }
        
        return false
    }
    
    func handleSongFinishedPlaying() {
        if !isNextSoundExist() {
            navigateToNextView = true
        } else {
            playNextSound()
        }
    }
    
    func toggleRepeat(){
        audioPlayer.toggleRepeat()
    }
    
    func reset() {
        selectedAlbum = albums.first
        soundIndex = 0
        audioPlayer.reset()
    }
}
