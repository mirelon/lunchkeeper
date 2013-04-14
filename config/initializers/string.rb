# encoding: utf-8
class String
  
  def strip_price
    self.sub(/[\d ]*,[\d ]*€/,"")
  end
  
  def remove_non_alpha
    self.gsub(/\p{^Alpha}/, '')
  end 
end