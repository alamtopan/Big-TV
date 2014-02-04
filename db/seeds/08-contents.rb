module SeedContent
  def self.seed
    contents = [
      {
        title: 'Top Slogan Bigtv',
        content_path: "#{Rails.root}/db/fixtures/contents/top_content.txt",
        picture: '',
        category: 'Slogan Bigtv'
      },
      {
        title: 'SLIDE_1',
        content_path: '',
        picture: "#{Rails.root}/public/content/slide/SLIDE_1.jpg",
        category: 'Slider Top'
      },
      {
        title: 'SLIDE_2',
        content_path: '',
        picture: "#{Rails.root}/public/content/slide/SLIDE_2.jpg",
        category: 'Slider Top'
      },
      {
        title: 'SLIDE_3',
        content_path: '',
        picture: "#{Rails.root}/public/content/slide/SLIDE_3.jpg",
        category: 'Slider Top'
      },
      {
        title: 'KUANTITAS',
        content_path: "#{Rails.root}/db/fixtures/contents/kuantitas.txt",
        picture: '',
        category: 'Fitur Content'
      },
      {
        title: 'KUALITAS',
        content_path: "#{Rails.root}/db/fixtures/contents/kualitas.txt",
        picture: '',
        category: 'Fitur Content'
      },
      {
        title: 'HARGA',
        content_path: "#{Rails.root}/db/fixtures/contents/harga.txt",
        picture: '',
        category: 'Fitur Content'
      },
      {
        title: 'BONUS',
        content_path: '',
        picture: "#{Rails.root}/public/content/BONUS.png",
        category: 'Tab Why BigTV'
      },
      {
        title: 'CHANNEL',
        content_path: '',
        picture: "#{Rails.root}/public/content/CHANNEL.png",
        category: 'Tab Why BigTV'
      },
      {
        title: 'KUALITAS',
        content_path: '',
        picture: "#{Rails.root}/public/content/KUALITAS.png",
        category: 'Tab Why BigTV'
      },
      {
        title: 'TERJANGKAU',
        content_path: '',
        picture: "#{Rails.root}/public/content/TERJANGKAU.png",
        category: 'Tab Why BigTV'
      },
      {
        title: 'LAYANAN',
        content_path: '',
        picture: "#{Rails.root}/public/content/LAYANAN.png",
        category: 'Tab Why BigTV'
      },
      {
        title: 'HYPERMART',
        content_path: "#{Rails.root}/db/fixtures/contents/hypermart.txt",
        picture: '',
        category: 'Tab Support Content'
      },
      {
        title: 'ATM',
        content_path: "#{Rails.root}/db/fixtures/contents/atm.txt",
        picture: '',
        category: 'Tab Support Content'
      },
      {
        title: 'TRANSFER',
        content_path: "#{Rails.root}/db/fixtures/contents/transfer.txt",
        picture: '',
        category: 'Tab Support Content'
      },
      {
        title: 'KARTU KREDIT',
        content_path: "#{Rails.root}/db/fixtures/contents/kartu_kredit.txt",
        picture: '',
        category: 'Tab Support Content'
      },
      {
        title: 'FOOTER CONTENT',
        content_path: "#{Rails.root}/db/fixtures/contents/footer_content.txt",
        picture: '',
        category: 'Footer Content'
      },
      {
        title: 'FOOTER ABOUT BIGTV',
        content_path: "#{Rails.root}/db/fixtures/contents/about_footer.txt",
        picture: '',
        category: 'Footer About Bigtv'
      }
      
    ]

    contents.each do |content|
      page_opts = {title: content[:title], category: content[:category]}
      page = PageContent.where(page_opts).first || PageContent.new(page_opts)
      page.description = File.open(content[:content_path]).read if content[:content_path].present? && File.exist?(content[:content_path])
      page.picture = File.new(content[:picture]) if content[:picture].present? && File.exist?(content[:picture])
      page.save
    end

  end
end
