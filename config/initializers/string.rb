# encoding: utf-8
class String
  def strip_price
    self.sub(/[\d ]*,[\d ]*€/,"")
  end
end