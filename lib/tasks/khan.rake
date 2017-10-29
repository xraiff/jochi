namespace :khan do

    task :delete => :environment do
        Node.delete_all
    end

    task :import_csv => :environment do
        file = File.open(Rails.root.join('data', 'khan.csv'), 'r')
        result = Node.import(file)
        puts result.to_s
    end

    task :json_to_csv => :environment do
        cmd = "jq --raw-output '..|select(.translated_title? != null) |"
        cmd += "select(.id? != null) | select(.kind? != null) | "
        cmd += "select(.kind as $values | [\"Video\", \"Exercise\", \"Article\", \"Scratchpad\"]) | "
        cmd += "[.kind?, .translated_title, .id?, .relative_url?, .slug?] | "
        cmd += "@csv' < #{Rails.root.join('data', 'khantopics-10-26-2017.json')} "
        cmd += "> #{Rails.root.join('data', 'khan.csv')}"
        `#{cmd}`
        `sed -i.old '1s;^;"type","title","khan_id","relative_url","slug"\\'$'\n;' #{Rails.root.join('data', 'khan.csv')}`
    end

end