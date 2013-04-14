# encoding: utf-8
class String
  
  def strip_price
    self.sub(/[\d ]*,[\d ]*€/,"")
  end
  
  def remove_non_alpha
    self.gsub(/\p{^Alpha}/, '')
  end

  def is_ok_for_stats
    self.length>2 and self.match(/[0-9]/).nil? and self.first!=" " and self.last!=" "
  end

end