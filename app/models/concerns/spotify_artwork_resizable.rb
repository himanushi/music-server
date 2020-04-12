module SpotifyArtworkResizable
  extend ActiveSupport::Concern

  included do
    before_create :resize_artwork
  end

  # artwork のサイズを実寸の値に変更
  # spotify のサイズは違うことが多々あるため実寸にしておく
  def resize_artwork
    self.artwork_l_width, self.artwork_l_height = Image.fetch_actual_size(artwork_l_url)
    self.artwork_m_width, self.artwork_m_height = Image.fetch_actual_size(artwork_m_url)
    self.artwork_s_width, self.artwork_s_height = Image.fetch_actual_size(artwork_s_url)
  end
end
