
# FindCaption

[![Fork](https://img.shields.io/github/forks/yusriltakeuchi/cakedetector?style=social)](https://github.com/yusriltakeuchi/findcaption/fork)&nbsp; [![Star](https://img.shields.io/github/stars/yusriltakeuchi/cakedetector?style=social)](https://github.com/yusriltakeuchi/findcaption/star)&nbsp; [![Watches](https://img.shields.io/github/watchers/yusriltakeuchi/cakedetector?style=social)](https://github.com/yusriltakeuchi/findcaption/)&nbsp;


<p><img  src="https://i.ibb.co/hB4t6Tj/Portfolio.png"/></p>

**Find Caption** adalah aplikasi yang berfungsi untuk mencari posisi track youtube berdasarkan sebuah kata kunci dan memutar video pada posisi track yang paling sesuai / dipilih.
Aplikasi ini mendukung jenis bahasa apapun tergantung dari ketersediaan subtitle pada video tersebut.

Misalnya videonya hanya support subtitle indonesia dan inggris, maka hanya bisa cari kata kunci berdasarkan 2 bahasa itu.

Hasil pencariannya akan dibagi 2 jenis:
1. Matching Sentence = Track subtitle yang sangat mirip dengan pencarian
2. Similar  = Track subtitle yang agak mirip dengan pencarian 

Dibangun dengan:
- Flutter sebagai Mobile Framework
- Python Flask sebagai API
- Heroku sebagai tempat untuk deploy API

Menggunakan Pattern MVVM dan state management Provider.

### Apps Feature:

 - Find Caption Subtitle
 - Support Multiple Language
 - Match and Similar Sentence
 

  ### Setup
 1. git clone https://github.com/yusriltakeuchi/findcaption.git
 2. flutter packages get
 3. flutter run
 4. Happy coding!
