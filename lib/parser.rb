
class Parser

  def self.parse(file)
    if File.exist?(file)
      CSV.open(file, headers: true, header_converters: :symbol)
    else
      return "file not found"
      # todo how to make this work
      #raise IOError, "#{file} not found!"
    end
  end
end




