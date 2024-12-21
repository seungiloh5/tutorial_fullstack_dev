mixin Musical {
  void playMusic() {
    print('Playing music');
  }
}

class Musician with Musical {}

void main() {
  var musician = Musician();
  musician.playMusic();
}
