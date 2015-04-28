
class CsvParser

  def self.parse(file)
    if File.exist?(file)
      CSV.open(file, headers: true, header_converters: :symbol)
    else
      raise IOError, "#{file} not found!"
    end
  end
end




