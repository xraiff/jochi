class Node < ::ApplicationRecord
    require 'csv'

    def self.import(file)
        skips = 0
        index = 0
        CSV.foreach(file.path, headers: true) do |row|
            begin
                Node.create! row.to_hash
                index += 1
            rescue
                skips += 1
            end
        end
        {imports: index, skips: skips}
    end
end
