module Worldfactbook
  require 'iconv'

  class Country

    @@rubyworldfactbook_location = "http://rubyworldfactbook.com"
    attr_accessor :country, :wfb_location

    attr_accessor :intro

    #geography ivars
    attr_accessor :location, :geographic_coordinates, :map_references, :area,
                  :area_comparative, :land_boundaries, :coastline, :maritime_claims,
                  :climate, :terrain, :elevation_extremes, :natural_resources, :land_use,
                  :irrigated_land, :total_water_resources, :freshwater_withdrawal,
                  :natural_hazards, :env_current_issues,
                  :env_intnl_agreements, :geography_note

    #people ivars
    attr_accessor :nationality, :ethnic_groups, :religions, :languages, :population,
                  :age_structure, :median_age, :population_growth_rate, :birth_rate,
                  :death_rate, :net_migration_rate, :urbanization, :major_cities_population,
                  :sex_ratio, :maternal_mortality_rate, :infant_mortality_rate, :life_expectancy,
                  :total_fertility_rate, :health_expenditures, :physician_density, :hospital_bed_density,
                  :drinking_water_source, :sanitation_facility_access, :aids_adult_prevalence,
                  :aids_people_living_with, :aids_deaths, :obesity, :children_underweight,
                  :education_expenditures, :literacy, :school_life_expectancy


    #government ivars
    attr_accessor :country_name, :government_type, :capital, :administrative_divisions,
                  :dependent_areas, :independence, :national_holiday, :constitution, :legal_system,
                  :international_law_org, :suffrage, :executive_branch, :legislative_branch, :judicial_branch,
                  :political_parties, :political_groups, :international_org, :flag_description, :national_symbol,
                  :national_anthem

    #economy ivars
    attr_accessor :economy_overview, :gdp_purchase_power, :gdp_exchange_rate,
                  :gdp_real_growth_rate, :gdp_per_capita, :gdp_composition, :labor_force,
                  :unemployment_rate, :youth_unemployment_rate, :population_in_poverty,
                  :household_income, :income_distribution, :investment, :budget, :taxes,
                  :public_debt, :inflation_rate, :central_bank_rate, :prime_rate, :narrow_money,
                  :broad_money, :domestic_credit, :public_shares_value, :agriculture_products,
                  :industries, :industrial_production_growth_rate, :electricity_production,
                  :electricity_consumption, :electricity_exports, :electricity_imports, :oil_production,
                  :oil_consumption, :oil_exports, :oil_imports, :oil_proved_reserves, :natural_gas_production,
                  :natural_gas_consumption, :natural_gas_exports, :natural_gas_imports,
                  :natural_gas_proved_reserves, :current_account_balance, :exports,
                  :exports_commodities, :exports_partners, :imports, :imports_commodities,
                  :imports_partners, :reserves_of_foreign_exchange, :debt, :foreign_stock_at_home,
                  :foreign_stock_abroad, :exchange_rates

    #communications ivars
    attr_accessor :telephone_lines, :mobile_lines, :telephone_system, :broadcast_media,
                  :internet_tld, :internet_hosts, :internet_users

    #transportation ivars
    attr_accessor :airports, :airports_paved, :airports_unpaved, :heliports, :pipelines,
                  :railways, :roadways, :waterways, :merchant_marine, :ports_and_terminals

    #military ivars
    attr_accessor :branches, :age_and_obligation, :manpower_available, :manpower_anual,
                  :military_expenditures

    #transnational issue ivars
    attr_accessor :disputes, :refugees, :drugs


    def initialize(country)
      @country = country.downcase
      @code = CountryCode.new(@country).code
      @ic = Iconv.new('UTF-8//IGNORE', 'UTF-8')
      @wfb_location = @@rubyworldfactbook_location
      @max_range = 100
      @global_fields = []
      @global = []
      @communications_fields = []
      @communications = []
      @economy_fields = []
      @economy = []
      @government_fields = []
      @government = []
      @geography_fields = []
      @geography = []
      @people_fields = []
      @people = []
      @count = 0
      offset = 1


      while(@count < @max_range)
        raw_global = doc.css("#CollapsiblePanel1_Issues tr:nth-child(#{@count}) #field")
        raw_comm = doc.css("#CollapsiblePanel1_Comm tr:nth-child(#{@count}) #field")
        raw_econ = doc.css("#CollapsiblePanel1_Econ tr:nth-child(#{@count}) #field")
        raw_gov = doc.css("#CollapsiblePanel1_Govt tr:nth-child(#{@count}) #field")
        raw_geo = doc.css("#CollapsiblePanel1_Geo tr:nth-child(#{@count}) #field")

        raw_people = doc.css("#CollapsiblePanel1_People tr:nth-child(#{@count}) #field")
        unless(raw_global.nil?)
          global_field =  (@ic.iconv(raw_global.text + ' ')[0..-2])
          glo =  (@ic.iconv(doc.css("#CollapsiblePanel1_Issues tr:nth-child(#{@count}) #data").text + ' ')[0..-2])
          @global[@count + offset] =  glo
          @global_fields[@count] =  global_field.gsub(/\s/, "")

        end

        unless(raw_comm.nil?)
          comm_field =  (@ic.iconv(raw_comm.text + ' ')[0..-2])
          comm =  (@ic.iconv(doc.css("#CollapsiblePanel1_Comm tr:nth-child(#{@count}) #data").text + ' ')[0..-2])
          @communications[@count + offset] =  comm
          @communications_fields[@count] =  comm_field.gsub(/\s/, "")
        end

        unless(raw_econ.nil?)
          econ_field =  (@ic.iconv(raw_econ.text + ' ')[0..-2])
          econ =  (@ic.iconv(doc.css("#CollapsiblePanel1_Econ tr:nth-child(#{@count}) #data").text + ' ')[0..-2])
          @economy[@count + offset] = econ
          @economy_fields[@count] = econ_field.gsub(/\s/,"")
        end

        unless(raw_gov.nil?)
          gov_field =  (@ic.iconv(raw_gov.text + ' ')[0..-2])
          gov =  (@ic.iconv(doc.css("#CollapsiblePanel1_Govt tr:nth-child(#{@count}) #data").text + ' ')[0..-2])
          @government[@count + offset] =  gov
          @government_fields[@count] =  gov_field.gsub(/\s/,"")
        end

        unless(raw_geo.nil?)
          geo_field =  (@ic.iconv(raw_geo.text + ' ')[0..-2])
          geo =  (@ic.iconv(doc.css("#CollapsiblePanel1_Geo tr:nth-child(#{@count }) #data").text + ' ')[0..-2])
          @geography[@count + offset] =  geo
          @geography_fields[@count] =  geo_field.gsub(/\s/,"")
        end

        unless(raw_people.nil?)
          people_field =  (@ic.iconv(raw_people.text + ' ')[0..-2])
          ppl =  (@ic.iconv(doc.css("#CollapsiblePanel1_People tr:nth-child(#{@count}) #data").text + ' ')[0..-2])
          @people[@count + offset] = ppl
          @people_fields[@count] = people_field.gsub(/\s/,"")
        end

        #puts "@people[#{@count}]  #{@people[@count + offset]}"
        #puts "@people_fields[#{@count}]  #{@people_fields[@count]}"

        @count +=1
      end

      self.process_global
      self.process_communications
      self.process_economy
      self.process_government
      self.process_geography
      self.process_intro
      self.process_people

    end

    def process_intro

      @intro =  (@ic.iconv(doc.css('#CollapsiblePanel1_Intro #data .category_data').text + ' ')[0..-2])
    end

    def process_geography
      count = 0
      @geography_fields.each do |element|
        unless @geography[count].nil? or @geography[count].empty?
          case element
            when ""

            when "Location:"
              @location = @geography[count]

            when "Geographiccoordinates:"
              @geographic_coordinates = @geography[count]

            when "Mapreferences:"
              @map_references = @geography[count]

            when "Area:"
              @area = @geography[count]
            when "Area-comparative:"
              @area_comparative = @geography[count]

            when "Landboundaries:"
              @land_boundaries = @geography[count]
            when "Coastline:"
              @coastline = @geography[count]

            when "Maritimeclaims:"
              @maritime_claims = @geography[count]

            when "Climate:"
              @climate = @geography[count]

            when "Terrain:"
              @terrain = @geography[count]

            when "Elevationextremes:"
              @elevation_extremes = @geography[count]

            when "Naturalresources:"
              @natural_resources = @geography[count]

            when "Landuse:"
              @land_use = @geography[count]
            when "Irrigatedland:"
              @irrigated_land = @geography[count]
            when "Totalrenewablewaterresources:"
              @total_water_resources = @geography[count]

            when "Freshwaterwithdrawaldomestic/industrial/agricultural):"
              @freshwater_withdrawal = @geography[count]

            when "Naturalhazards:"
              @natural_hazards = @geography[count]

            when "Environment-current issues:"
              @env_current_issues = @geography[count]

            when "Environment-internationalagreements:"
              @env_intnl_agreements = @geography[count]

            when "Geography-note:"
              @geography_note = @geography[count]

          end

          count += 1
        end
      end
    end

    def process_people
      count = 0

      @people_fields.each do |element|
        unless @people[count].nil? or @people[count].empty?
          case element
            when ""

            when "Nationality:".gsub(/\s/,"")
              @nationality = @people[count]

            when "Ethnic groups:".gsub(/\s/,"")
              @ethnic_groups = @people[count]

            when "Religions:".gsub(/\s/,"")
              @religions = @people[count]
            when "Languages:".gsub(/\s/,"")
              @languages = @people[count]
            when "Population:".gsub(/\s/,"")
              @population = @people[count]

            when "Age structure:".gsub(/\s/,"")
              @age_structure = @people[count]

            when "Median age:".gsub(/\s/,"")
              @median_age = @people[count]

            when "Population growth rate:".gsub(/\s/,"")
              @population_growth_rate = @people[count]

            when "Birth rate:".gsub(/\s/,"")
              @birth_rate = @people[count]

            when "Death rate:".gsub(/\s/,"")
              @death_rate = @people[count]

            when "Net migration rate:".gsub(/\s/,"")
              @net_migration_rate = @people[count]

            when "Urbanization:".gsub(/\s/,"")
              @urbanization = @people[count]

            when "Major cities - population:".gsub(/\s/,"")
              @major_cities_population = @people[count]

            when "Sex ratio:".gsub(/\s/,"")
              @sex_ratio = @people[count]

            when "Maternal mortality rate:".gsub(/\s/,"")
              @maternal_mortality_rate = @people[count]

            when "Infant mortality rate:".gsub(/\s/,"")
              @infant_mortality_rate = @people[count]

            when "Life expectancy at birth:".gsub(/\s/,"")
              @life_expectancy = @people[count]

            when "Total fertility rate:".gsub(/\s/,"")
              @total_fertility_rate = @people[count]

            when "Health expenditures:".gsub(/\s/,"")
              @health_expenditures = @people[count]

            when "Physicians density:".gsub(/\s/,"")
              @physician_density = @people[count]

            when "Hospital bed density:".gsub(/\s/,"")
              @hospital_bed_density = @people[count]

            when "Drinking water source:".gsub(/\s/,"")
              @drinking_water_source = @people[count]

            when "Sanitation facility access:".gsub(/\s/,"")
              @sanitation_facility_access = @people[count]

            when "HIV/AIDS - adult prevalence rate:".gsub(/\s/,"")
              @aids_adult_prevalence = @people[count]

            when "HIV/AIDS - people living with HIV/AIDS:".gsub(/\s/,"")
              @aids_people_living_with = @people[count]

            when "HIV/AIDS - deaths:".gsub(/\s/,"")
              @aids_deaths = @people[count]
            when "Obesity - adult prevalence rate:".gsub(/\s/,"")
              @obesity = @people[count]

            when "Children under the age of 5 years underweight:".gsub(/\s/,"")
              @children_underweight = @people[count]

            when "Education expenditures:".gsub(/\s/,"")
              @education_expenditures = @people[count]

            when "Literacy:".gsub(/\s/,"")
              @literacy = @people[count]

            when "School life expectancy (primary to tertiary education):".gsub(/\s/,"")
              @school_life_expectancy = @people[count]


          end
          count += 1
        end
      end
    end

    def process_government
      count = 0

      @government_fields.each do |element|
        case element
          when ""

          when "Country name:"

            @country_name = @government[count]

          when "Government type:"
            @government_type = @government[count]

          when "Capital:"
            @capital = @government[count]

          when "Administrative divisions:"
            @administrative_divisions = @government[count]

          when "Dependent areas:"
            @dependent_areas = @government[count]

          when "Independence:"
            @independence = @government[count]

          when "National holiday:"
            @national_holiday = @government[count]

          when "Constitution:"
            @constitution = @government[count]
          when "Legal system:"
            @legal_system = @government[count]
          when "International law organization participation:"
            @international_law_org = @government[count]

          when "Suffrage:"
            @suffrage = @government[count]

          when "Executive branch:"
            @executive_branch = @government[count]

          when "Legislative branch:"
            @legislative_branch = @government[count]

          when "Judicial branch:"
            @judicial_branch = @government[count]

          when "Political parties and leaders:"
            @political_parties = @government[count]

          when "Political pressure groups and leaders:"
            @political_groups = @government[count]

          when "International organization participation:"
            @international_org = @government[count]

          when "Flag description:"
            @flag_description = @government[count]

          when "National symbol(s):"
            @national_symbol = @government[count]

          when "National anthem:"
            @national_anthem = @government[count]


        end
        count += 1
      end

    end

    def process_economy

    end

    def process_communications

    end

    def process_global

    end

    def countries
      CountryCode.new(@country).list
    end

    def flag
      (@ic.iconv(doc.css('.flag_border').to_s + ' ')[0..-2]).gsub(/\.\.\/graphics/,"#{@wfb_location}/graphics").gsub(/"/,'').scan(/http\S+/)[0]
    end

    def map_location
      (@ic.iconv(doc.css('#region-content td tr:nth-child(2) td:nth-child(2) img:nth-child(1)').to_s + ' ')[0..-2]).gsub(/\.\.\/graphics/,"#{@wfb_location}/graphics").gsub(/"/,'').scan(/http\S+/)[0]
    end

    def map_world
      "#{@wfb_location}/graphics/maps/newmaps/#{@code}-map.gif"
    end


    def geography
      { 'location' => self.location, 'area' => self.area, 'area_comparative' => self.area_comparative, 'climate' => self.climate, 'terrain' => self.terrain, 'elevation' => self.elevation, 'natural_resources' => self.natural_resources }
    end

    def people
      { 'population' => self.population, 'population_growth' => self.population_growth, 'ethnic_groups' => self.ethnic_groups, 'religions' => self.religions, 'languages' => self.languages, 'sex_ratio' => self.sex_ratio, 'age_structure' => self.age_structure, 'median_age' => self.median_age, 'birth_rate' => self.birth_rate, 'death_rate' => self.death_rate, 'net_migration' => self.net_migration, 'urbanization' => self.urbanization, 'major_cities' => self.major_cities, 'infant_mortality' => self.infant_mortality, 'life_expectancy' => self.life_expectancy, 'fertility_rate' => self.fertility_rate, 'literacy' => self.literacy }
    end

    def government
      { 'government_type' => government_type, 'capital' => self.capital, 'independence' => self.independence, 'legal' => self.legal, 'executive' => self.executive, 'legislative' => self.legislative, 'judicial' => self.judicial, 'political' => self.political }
    end

    def economy
      { 'gdp' => self.gdp, 'gdp_ppp' => self.gdp_ppp, 'gdp_growth' => self.gdp_growth, 'gdp_capita' => self.gdp_capita, 'gdp_sectors' => self.gdp_sectors, 'labor' => self.labor, 'unemployment' => self.unemployment, 'inflation' => self.inflation, 'markets' => self.markets, 'exports' => self.exports, 'imports' => self.imports, 'debt' => self.debt, 'military' => self.military }

      # economy_overview not included
    end

    def communications
      { 'telephones' => self.telephones, 'cellphones' => self.cellphones, 'internet_users' => self.internet_users, 'internet_hosts' => self.internet_hosts }
    end

    def global
      { 'disputes' => self.disputes, 'refugees' => self.refugees, 'drugs' => self.drugs }
    end



    #fall back to looking for items by document structure
    def get_geo_for(child_id)
      (@ic.iconv(doc.css("#CollapsiblePanel1_Geo tr:nth-child(#{child_id}) #data").text + ' ')[0..-2])
    end

      #fall back to looking for items by document structure
    def get_people_for(child_id)
      @people[child_id]
    end

    def location
      child_id = 2
      @location ||= get_geo_for(child_id)
    end

    def geographic_coordinates
      child_id = 5
      @geographic_coordinates ||= get_geo_for(child_id)
    end

    def map_references
      child_id = 8
      @map_references ||= get_geo_for(child_id)
    end

    def area
      child_id = 11
      @area ||=  get_geo_for(child_id)
    end

    def area_comparative
      child_id = 14
      @area_comparative ||= get_geo_for(child_id)
    end

    def land_boundaries
      child_id = 17
      @land_boundaries ||= get_geo_for(child_id)
    end
    def coastline
      child_id = 20
      @coastline ||= get_geo_for(child_id)
    end
    def maritime_claims
      child_id = 23
      @maritime_claims ||= get_geo_for(child_id)
    end

    def climate
      child_id = 26
      @climate ||= get_geo_for(child_id)
    end

    def terrain
      child_id = 29
      @terrain ||= get_geo_for(child_id)
    end

    def elevation
      child_id = 32
      @elevation_extremes ||= get_geo_for(child_id)
    end

    def natural_resources
      child_id = 35
      @natural_resources ||= get_geo_for(child_id)
    end

    def land_use
      child_id = 38
      @land_use ||= get_geo_for(child_id)
    end

    def irrigated_land
      child_id = 41
      @irrigated_land ||= get_geo_for(child_id)
    end

    def total_water_resources
      child_id = 44
      @total_water_resources ||= get_geo_for(child_id)
    end

    def freshwater_withdrawal
      child_id = 47
      @freshwater_withdrawal ||= get_geo_for(child_id)
    end

    def natural_hazards
      child_id = 50
      @natural_hazards ||= get_geo_for(child_id)
    end

    def env_current_issues
      child_id = 53
      @env_current_issues ||= get_geo_for(child_id)
    end

    def env_intnl_agreements
      child_id = 56
      @env_intnl_agreements ||= get_geo_for(child_id)
    end

    def geography_note
      child_id = 59
      @geography_note ||= get_geo_for(child_id)
    end



    ## PEOPLE ##

    def nationality
      child_id = 57
      @nationality ||= get_people_for(child_id)
    end

    def ethnic_groups
      child_id = 60
      @ethnic_groups ||= get_people_for(child_id)
    end

    def religions
      child_id = 63
      @religions ||= get_people_for(child_id)
    end

  def languages
    child_id = 66
    @languages ||= get_people_for(child_id)
  end

  def population
    child_id = 69
    @population ||= get_people_for(child_id)
  end

  def age_structure
    child_id = 17
    @age_structure ||= get_people_for(child_id)
  end

    def median_age
      child_id = 20
      @median_age ||= get_people_for(child_id)
    end

    def population_growth
      child_id = 23
      @population_growth_rate ||= get_people_for(child_id)
    end

    def birth_rate
      child_id = 26
      @birth_rate ||= get_people_for(child_id)
    end

    def death_rate
      child_id = 29
      @death_rate  ||= get_people_for(child_id)
    end

    def net_migration
      child_id = 32
      @net_migration_rate  ||= get_people_for(child_id)
    end

    def urbanization
      child_id = 35
      @urbanization ||= get_people_for(child_id)
    end

    def major_cities
      child_id = 38
      @major_cities_population  ||= get_people_for(child_id)
    end

    def sex_ratio
      child_id = 41
      @sex_ratio  ||= get_people_for(child_id)
    end

    def maternal_mortality_rate
      child_id = 44
      @maternal_mortality_rate  ||= get_people_for(child_id)
    end

    def infant_mortality
      child_id = 47
      @infant_mortality_rate  ||= get_people_for(child_id)
    end

    def life_expectancy
      child_id = 50
      @life_expectancy  ||= get_people_for(child_id)
    end

    def fertility_rate
      child_id = 53
      @total_fertility_rate  ||= get_people_for(child_id)
    end

    def health_expenditures
      child_id = 56
      @health_expenditures  ||= get_people_for(child_id)
    end

    def physician_density
      child_id = 59
      @physician_density  ||= get_people_for(child_id)
    end

    def hospital_bed_density
      child_id = 62
      @hospital_bed_density  ||= get_people_for(child_id)
    end

    def drinking_water_source
      child_id = 51
      @drinking_water_source  ||= get_people_for(child_id)
    end

    def sanitation_facility_access
      child_id = 54
      @sanitation_facility_access  ||= get_people_for(child_id)
    end

    def aids_adult_prevalence
      child_id = 71
      @aids_adult_prevalence  ||= get_people_for(child_id)
    end

    def aids_people_living_with
      child_id = 74
      @aids_people_living_with  ||= get_people_for(child_id)
    end

    def obesity
      child_id = 77
      @obesity  ||= get_people_for(child_id)
    end

    def children_underweight
      child_id = 80
      @children_underweight ||= get_people_for(child_id)
    end

    def education_expenditures
      child_id = 75
      @education_expenditures  ||= get_people_for(child_id)
    end

    def literacy
      child_id = 86
      @literacy  ||= get_people_for(child_id)
    end

    def school_life_expectancy
      child_id = 72
      @school_life_expectancy  ||= get_people_for(child_id)
    end


    ## GOVERNMENT ##

    def government_type
      (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(5) .category_data').text + ' ')[0..-2])
    end

    def capital
      (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(8) #data').text + ' ')[0..-2])
    end

    def independence
      if (@ic.iconv(doc.to_s + ' ')[0..-2]).match("Definitions and Notes: Dependent areas")
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(17) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      else
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(14) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      end
    end

    def legal
      if (@ic.iconv(doc.to_s + ' ')[0..-2]).match("Definitions and Notes: Dependent areas")
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(26) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      else
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(23) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      end
    end

    def executive
      if (@ic.iconv(doc.to_s + ' ')[0..-2]).match("Definitions and Notes: Dependent areas")
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(35) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      else
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(32) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      end
    end

    def legislative
      if (@ic.iconv(doc.to_s + ' ')[0..-2]).match("Definitions and Notes: Dependent areas")
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(38) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      else
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(35) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      end
    end

    def judicial
      if (@ic.iconv(doc.to_s + ' ')[0..-2]).match("Definitions and Notes: Dependent areas")
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(41) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      else
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(38) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      end
    end


    def political
      if (@ic.iconv(doc.to_s + ' ')[0..-2]).match("Definitions and Notes: Dependent areas")
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(44) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      else
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(41) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      end
    end

    def flag_description
      if (@ic.iconv(doc.to_s + ' ')[0..-2]).match("Definitions and Notes: Dependent areas")
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(53) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      else
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(50) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      end
    end

    def national_symbols
      if (@ic.iconv(doc.to_s + ' ')[0..-2]).match("Definitions and Notes: Dependent areas")
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(56) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      else
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(53) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      end
    end

    def national_anthem
      if (@ic.iconv(doc.to_s + ' ')[0..-2]).match("Definitions and Notes: Dependent areas")
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(59) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      else
        (@ic.iconv(doc.css('#CollapsiblePanel1_Govt tr:nth-child(56) #data').text + ' ')[0..-2]).squeeze(' ').gsub(/[\r\t\n]/,'').strip
      end
    end

    ## ECONOMY ##

    def economy_overview
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(2) .category_data').text + ' ')[0..-2])
    end

    def gdp
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(8) .category_data').text + ' ')[0..-2])
    end

    def gdp_ppp
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(5) #data').text + ' ')[0..-2])
    end

    def gdp_growth
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(11) #data').text + ' ')[0..-2])
    end

    def gdp_capita
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(14) #data').text + ' ')[0..-2])
    end

    def gdp_sectors
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(17) #data').text + ' ')[0..-2])
    end

    def labor
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(20) #data').text + ' ')[0..-2])
    end

    def unemployment
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(26) #data').text + ' ')[0..-2])
    end

    def inflation
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(47) #data').text + ' ')[0..-2])
    end

    def markets
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(65) #data').text + ' ')[0..-2])
    end

    def exports
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(122) #data').text + ' ')[0..-2])
    end

    def imports
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(131) #data').text + ' ')[0..-2])
    end

    def debt
      (@ic.iconv(doc.css('#CollapsiblePanel1_Econ tr:nth-child(143) #data').text + ' ')[0..-2])
    end

    def military
      (@ic.iconv(doc.css('#CollapsiblePanel1_Military tr:nth-child(17) #data').text + ' ')[0..-2]).squeeze(' ')
    end


    ## COMMUNICATIONS ##

    def telephones
      (@ic.iconv(doc.css('#CollapsiblePanel1_Comm tr:nth-child(2) #data').text + ' ')[0..-2]).squeeze(' ')
    end

    def cellphones
      (@ic.iconv(doc.css('#CollapsiblePanel1_Comm tr:nth-child(5) #data').text + ' ')[0..-2]).squeeze(' ')
    end

    def internet_users
      if @code == 'xx'
        (@ic.iconv(doc.css('#CollapsiblePanel1_Comm tr:nth-child(11) .category_data').text + ' ')[0..-2]).squeeze(' ')
      elsif @code == 'ee'
        (@ic.iconv(doc.css('#CollapsiblePanel1_Comm tr:nth-child(17) .category_data').text + ' ')[0..-2]).squeeze(' ')
      else
        (@ic.iconv(doc.css('#CollapsiblePanel1_Comm tr:nth-child(20) #data').text + ' ')[0..-2]).squeeze(' ')
      end
    end

    def internet_hosts
      (@ic.iconv(doc.css('#CollapsiblePanel1_Comm tr:nth-child(17) #data').text + ' ')[0..-2]).squeeze(' ')
    end


    ## GLOBAL ISSUES ##

    def disputes
      (@ic.iconv(doc.css('#CollapsiblePanel1_Issues tr:nth-child(2) .category_data').text + ' ')[0..-2])
    end

    def refugees
      (@ic.iconv(doc.css('#CollapsiblePanel1_Issues tr:nth-child(5) .category_data').text + ' ')[0..-2])
    end

    def drugs
      (@ic.iconv(doc.css('#CollapsiblePanel1_Issues tr:nth-child(8) .category_data').text + ' ')[0..-2])
    end


    private

    def doc
      if(@wfb_location == @@rubyworldfactbook_location)
        @document ||= Nokogiri::HTML(open("#{@wfb_location}/geos/#{@code}.html"))
      else
        File.open("#{@wfb_location}/geos/#{@code}.html") do |file|
          @document ||= Nokogiri::HTML(file)
        end
      end
    end
  end

end
