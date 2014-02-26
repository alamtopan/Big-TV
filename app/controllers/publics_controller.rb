class PublicsController < ApplicationController
  layout "public"  # Render layout template Public halaman depan

  # Fungsi Show data dihalaman Home/Depan bigtv
	def show
		if params[:regional]
			regional = params[:regional]
		else
			regional = "Sumatra"
		end
    @blogs         = Blog.published # Show data promo/news
    @categories    = CategoryOffice.includes(offices: [:category_office, :regional]).all # Show data kategori office
    @regionals     = Regional.all # Show data regional

    @memberships   = Membership.packages_by_category('premium') # Show paket premium
    @memberships_extra = Membership.packages_by_category('extra').by_position # Show data extra paket
    @groups        = GroupItem.includes(unit_items: [:memberships]).by_position # Show data group paket
    @free_channels = UnitItem.free_channels # Show data channels

    @features  = PageContent.where("category =?", "Fitur Content").order('id ASC') # Show data fitur
    @why_bigtv   = PageContent.where("category =?", "Tab Why BigTV").published.order('id ASC') # Show data why bigtv content
    
	end

  # Halaman Thanks dengan render template invoice
  def thanks
    prepare_order_by_token('invoice')
  end

  # Halaman Payment intruction dengan render template invoice
  def payment_instruction
    prepare_order_by_token('invoice')
  end

  # Halaman lokasi dengan format map
  def render_map
    return unless params[:regional]
    regional = params[:regional]
    @locations_google= Office.packages_by_map(regional)
    render partial: 'map'
  end

  # Fungsi yang ada di Halaman lokasi
  def lokasi
    @title_page = "Lokasi" # Display title
    @categories= CategoryOffice.all
    @regionals= Regional.all
    render layout: "detail" # Render template detail
  end

  # Fungsi yang ada di Halaman cara berlangganan
  def cara_berlangganan
    @title_page = "Cara Berlangganan" # Display title cara berlangganan
    render layout: "detail_lanjut" # Render template detail_lanjut
  end

  # Fungsi yang ada di Halaman support
  def support
    @title_page = "Support" # Display title support
    @support_pembayaran   = PageContent.where("category =?", "Tab Support Content").published.order('id ASC') # Show data tab support pembayaran
    @support_faq   = PageContent.where("category =?", "Tab Support Content FAQ").published.order('id ASC') # Show data tab faq support pembayaran
    @service = Service.new
    choice
    render layout: "detail" # Render template detail
  end

  # Fungsi yang dipakai untuk create Service request
  def create_support
    @service = Service.new(params[:service])
    if @service.save
      CustomerMailer.service_request(@service).deliver
      flash[:notice] = "
                          Terima kasih atas data yang telah Anda 
                          lengkapi ke dalam Service Request. <br>
                          Mohon maaf sebelumnya atas ketidaknyamanan Bapak/Ibu. <br>
                          Untuk selanjutnya akan kami proses dalam waktu 1x24Jam untuk menghubungi Bapak/Ibu kembali
                       "
      redirect_to support_path # Redirect kembali kehalaman support
    end
  end

  # Fungsi yang ada di Halaman carrier
  def carriers
    @title_page = "Carrier" # Display title carrier
    @jobs = Job.published # Show data jobs
    render layout: "detail" # Render template detail
  end

  # Fungsi yang dipakai di halaman detail carrier
  def show_carrier
    @job = Job.where(id: params[:id]).first
    @job_applicant = JobApplicant.new
    @title_page = "#{@job.position}" if @job
    render layout: "detail" # Render template detail
  end

  # Fungsi yang dipakai untuk create Job
  def create_job
    @job_applicant = JobApplicant.new(params[:job_applicant])
    if @job_applicant.file_resume_file_size >= 2000000
      flash[:alert] = "
                          File resume terlalu besar untuk dikirim..!<br>
                          File resume maximal 2MB
                       "
      redirect_to :back
    elsif 
      @job_applicant.save
      CustomerMailer.job_request(@job_applicant).deliver
      flash[:notice] = "
                          Terima kasih atas data lamaran yang anda kirim..! <br>
                          Untuk selanjutnya akan kami kirimkan balasan kembali ke email anda.
                       "
      redirect_to carriers_path # Redirect kembali kehalaman carriers
    end
  end


  # Fungsi yang dipakai di halaman detail promo/news
  def show_blog
    @blog = Blog.where(slug: params[:id]).first
    @title_page = "#{@blog.title}" if @blog
    render layout: "detail" # Render template detail
  end

  private
    def prepare_order_by_token(layout_name='detail')
      if params[:token].present? && @order = Order.find_by_token(params[:token])
        @customer         = @order.orderable
        @customer_profile = @customer.profile
        render layout: layout_name
      else
        redirect_to root_path
      end
    end

    # Fungsi select di form service request
    def choice
      @problem      = [
                         'Gambar sering kabur atau muncul tulisan No Signal',
                         'Di dalam layar terdapat tulisan "Access Danied" atau "Card Not Paired"',
                         'Box tidak menyala',
                         'Masalah lainnya'
                      ]

      @program      = ['Pre Paid','Post Paid']
      @day_problem  = ['1-2 Hari','3-7 Hari','>15 Hari']
      @status       = ['IN PROGRESS','DONE','FAILED']

    end

end
