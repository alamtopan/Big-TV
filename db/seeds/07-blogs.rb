module SeedBlog
  def self.seed
  	title_list = ["PELUNCURAN SATELIT","APLIKASI SEPAKBOLA","4 IN ONE CHANNEL"]
  	desc_list = [
  		"Dengan total investasi lebih dari 300 juta dolar AS, BiGTV menawarkan kebebasan dalam mengakses program-program televisi yang terbaik bagi masyarakat di tanah air. Salah satu bentuk investasi tersebut adalah satelit Lippo Star 1 (KU Band MPEG4) yang diluncurkan tahun lalu di French Guiana. Dilengkapi 12 KU Band transponder, yang keseluruhannya mencakup ke Indonesia, Lippo Star 1 saat ini memiliki jumlah transponder terbanyak di Indonesia. Hal ini memungkinkan BiGTV untuk menyiarkan lebih banyak saluran televisi, baik dalam SD maupun HD, sekaligus menjadikannya TV satelit berbayar pertama yang menyajikan saluran HD lebih banyak bagi para konsumennya.",
  		"Ingin tahu jadwal pertandingan, atau hasil pertandingan? Mudah, tekan tombol merah di remote control Decoder LG Anda di saat Anda menonton channel beIN SPORT 1 atau beIN SPORT 2. Aplikasi sepakbola akan membantu Anda dengan data-data sepakbola terkini untuk melengkapi pengalaman menonton Anda.",
  		"Bingung ingin menonton acara olahraga yang mana? di channel mana? coba pilih channel 4 in 1 kami untuk melihat secara serempak 4 channel yang berbeda. Nikmati layanan ini di channel BiG Show."
  		]
  	author_list = ["Admin"]

  	title_list.each do |title|
  		desc_list.each do |des|
		  	Location.create( :title => title, :description => des, :author => author )
		  end
		end
  end
end
