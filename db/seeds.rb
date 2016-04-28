require 'pry-byebug'
require 'csv'
require 'rest-client'

sectors = [
"Basic Industries",
"Capital Goods",
"Consumer Durables",
"Consumer Non-Durables",
"Consumer Services",
"Energy",
"Finance",
"Health Care",
"Miscellaneous",
"Public Utilities",
"Technology",
"Transportation",
"n/a"
]


sectors.each do |sector|
  Industry.create({
    name: sector
    })
end


10.times do
  user = User.create({
    email: Faker::Internet.free_email,
    password: "test123"
    })

  2.times do

    portfolio = Portfolio.create({
      name: Faker::Lorem.word,
      user_id: user.id
      })


    3.times do
      holding = Holding.new({
        symbol: "AA",
        allocation: 0.35,
        stock_id: rand(50),
        portfolio_id: portfolio.id
        })
    end
  end
end

User.create(email:"test@gmail.com", password:"1234")


def parse_csv(file_path)
  csv = CSV.open(file_path, :headers => true)
  stock_arr = csv.map{|row| row.to_hash}
  return stock_arr
end

nasdaq_stocks = parse_csv('nasdaq.csv')
stocks_without_images = []


nasdaq_stocks.each do |stock|
    name = stock.name
    site = "https://www.google.com/search?q=#{name}+logo&tbs=ic:trans&tbm=isch&tbas=0&source=lnt&sa=X&ved=0ahUKEwjYipaC8K_MAhURymMKHZ9UCz0QpwUIFA&dpr=1&biw=1920&bih=686"

    response = RestClient.get site
    doc = Nokogiri::HTML(response)
    image_url = doc.xpath("//a")[37].children[0].attributes["src"].value

    new_stock = Stock.new(symbol: stock["Symbol"],
   name: stock["Name"],
   sector: stock["Sector"],
   image_url: image_url
   )

  sector = Industry.find_by(name: "#{new_stock.sector}")
  sector.stocks << new_stock
  new_stock.save
end
StocksUser.create(user_id: 1, stock_id: 1)
StocksUser.create(user_id: 1, stock_id: 2)
StocksUser.create(user_id: 1, stock_id: 3)
StocksUser.create(user_id: 1, stock_id: 4)

@s = Stock.all

#Seed Users
User.create(email: "sam@aol.com", password: "1234")

Portfolio.create(name: "Value Compounding Fund", description: "A fund with all undervalued stocks listed in Nasdaq", user_id: 12)
Portfolio.create(name: "High Growth Fund", description: "A fund with high growth tech stocks", user_id: 12)
Portfolio.create(name: "Vanguard Fund", description: "A fund mimicking the actual Vanguard Fund", user_id: 12)
Portfolio.create(name: "Blackrock Index Fund", description: "A normal fund tracking the S&P index", user_id: 12)
Portfolio.create(name: "Quantum Testing Fund", description: "Quantum fund, still testing my strategy", user_id: 12)
Portfolio.create(name: "Google AlphaGo Fund", description: "Google AlphaGo machine learning comes into play!", user_id: 12)
Portfolio.create(name: "Microsoft Dividend Fund", description: "A fund to beat the inflation", user_id: 12)


# @s.each do |a|
#    a.image_url = "http://logo.clearbit.com/#{a.name.downcase.chomp.split(" ")[0]}.com"
#    a.save
# end

# begin
  #  response = RestClient.get "http://www.nasdaq.com/logos/#{stock['Symbol']}.gif"
  # rescue
  #   puts "Stock Not found"
  # end

  #  if response
  #   image_url = "http://www.nasdaq.com/logos/#{stock["Symbol"]}.gif"
  #   return_image = true
  #  # "http://logo.clearbit.com/#{stock["Name"].downcase.chomp.split(" ")[0]}.com"
  #  else
  #   return_image = false
  #  end

# symbols = ["TFSC", "TFSCR", "TFSCU", "TFSCW", "PIH", "FLWS",
#  "FCTY", "FCCY", "SRCE", "VNET", "TWOU", "JOBS", "CAFD", "EGHT",
#  "AVHI", "SHLM", "AAON", "ABAX", "ABY", "ABGB", "ABEO", "ABEOW",
#  "ABIL", "ABMD", "AXAS", "ACTG", "ACHC", "ACAD", "ACST", "AXDX",
#  "XLRN", "ANCX", "ARAY", "VXDN", "VXUP", "ACRX", "ACET", "AKAO",
#  "ACHN", "ACIW", "ACRS", "ACNB", "ACOR", "ACTS", "ACPW", "ATVI",
#  "ACTA", "ACUR", "ACXM", "ADMS", "ADMP", "ADAP", "ADUS", "AEY",
#  "IOTS", "ADMA", "ADBE", "ADTN", "ADRO", "AAAP", "AEIS", "AITP",
#  "AMD", "ADXS", "ADXSW", "MAUI", "YPRO", "AEGR", "AEGN", "AGLE",
#  "AEHR", "AMTX", "AEPI", "AERI", "AVAV", "AEZS", "AEMD", "AFMD",
#  "AGEN", "AGRX", "AGYS", "AGIO", "AGFS", "AGFSW", "AIMT", "AIRM",
#  "AIRT", "ATSG", "AMCN", "AIXG", "AKAM", "AKTX", "AKBA", "AKER",
#  "AKRX", "ALRM", "ALSK", "AMRI", "ABDC", "ADHD", "ALDR", "ALDX",
#  "ALXN", "ALXA", "ALCO", "ALGN", "ALIM", "ALKS", "ABTX", "ALGT",
#  "AFOP", "AIQ", "AHGP", "ARLP", "AHPI", "AMOT", "ALQA", "ALLT",
#  "MDRX", "AFAM", "ALNY", "AOSL", "GOOG", "GOOGL", "SMCP", "ATEC",
#  "ASPS", "AIMC", "AMAG", "AMRN", "AMRK", "AYA", "AMZN", "AMBC",
#  "AMBCW", "AMBA", "AMCX", "DOX", "AMDA", "AMED", "UHAL", "ATAX",
#  "AMOV", "AAL", "AGNC", "AGNCB", "AGNCP", "MTGE", "CRAY", "MTGEP",
#  "ACSF", "ACAS", "GNOW", "AETI", "AMIC", "AMNB", "ANAT", "APEI",
#  "ARII", "AMRB", "ASEI", "AMSWA", "AMSC", "AMWD", "CRMT", "ABCB",
#  "AMSF", "ASRV", "ASRVP", "ATLO", "AMGN", "FOLD", "AMKR", "AMPH",
#  "IBUY", "AMSG", "AMSGP", "ASYS", "AFSI", "AMRS", "ANAC", "ADI",
#  "ALOG", "AVXL", "ANCB", "ABCW", "ANDA", "ANDAR", "ANDAU", "ANDAW",
#  "ANGI", "ANGO", "ANIP", "ANIK", "ANSS", "ATRS", "ANTH", "ABAC",
#  "ZLIG", "ATNY", "APIC", "APOG", "APOL", "AINV", "AMEH", "APPF",
#  "AAPL", "ARCI", "APDN", "APDNW", "AGTC", "AMAT", "AMCC", "AAOI",
#  "AREX", "APRI", "APTO", "AQMS", "AQXP", "AUMA", "AUMAU", "AUMAW",
#  "ARDM", "ARLZ", "PETX", "ABUS", "ARCW", "ABIO", "RKDA", "ARCB",
#  "ACGL", "APLP", "ACAT", "ARDX", "ARNA", "ARCC", "AGII", "AGIIL",
#  "ARGS", "ARIS", "ARIA", "ARKR", "ARMH", "ARTX", "ARWA", "ARWAR",
#  "ARWAU", "ARWAW", "ARQL", "ARRY", "ARRS", "DWAT", "AROW", "ARWR",
#  "ARTNA", "ARTW", "PUMP", "ASBB", "ASNA", "ASND", "ASCMA", "APWC",
#  "ASML", "AZPN", "ASMB", "ASFI", "ASTE", "ALOT", "ATRO", "ASTC",
#  "ASUR", "ATAI", "ATRA", "ATHN", "ATHX", "AAPC", "AAME", "ACBI",
#  "ACFC", "ATNI", "ATLC", "AAWW", "AFH", "TEAM", "ATOS", "ATRC",
#  "ATRI", "ATTU", "LIFE", "AUBN", "AUDC", "AUPH", "EARS", "ABTL",
#  "ADSK", "AGMX", "ADP", "AAVL", "AVNU", "AVEO", "AVXS", "AVNW",
#  "AVID", "AVGR", "AVIR", "CAR", "AWRE", "ACLS", "AXGN", "AXSM",
#  "AXTI", "BCOM", "RILY", "BOSC", "BEAV", "BIDU", "BCPC", "BWINA",
#  "BWINB", "BLDP", "BANF", "BANFP", "BKMU", "BOCH", "BMRC", "BKSC",
#  "BOTJ", "OZRK", "BFIN", "BWFG", "BANR", "BZUN", "BHAC", "BHACR",
#  "BHACU", "BHACW", "BBSI", "BSET", "BYBK", "BYLK", "BV", "BBCN",
#  "BCBP", "BECN", "BSF", "BBGI", "BEBE", "BBBY", "BGNE", "BELFA",
#  "BELFB", "BLPH", "BLCM", "BNCL", "BNFT", "BNTC", "BNTCW", "BGCP",
#  "BGFV", "BIND", "ORPN", "BASI", "BIOC", "BCRX", "BIOD", "BDSI",
#  "BIIB", "BIOL", "BLFS", "BOLT", "BLRX", "BMRN", "BVXV", "BVXVW",
#  "BPTH", "BIOS", "BBC", "BBP", "BSTC", "BSTG", "BSPM", "TECH",
#  "BEAT", "BITI", "BDMS", "BJRI", "BBOX", "BDE", "BLKB", "BBRY",
#  "HAWK", "BKCC", "ADRA", "ADRD", "ADRE", "ADRU", "BLMN", "BCOR",
#  "BLBD", "BUFF", "BHBK", "NILE", "BLUE", "BKEP", "BKEPP", "BPMC",
#  "ITEQ", "STCK", "BNCN", "BOBE", "BOFI", "BOFIL", "WIFI", "BOJA",
#  "BOKF", "BNSO", "BPFH", "BPFHP", "BPFHW", "EPAY", "BLVD", "BLVDU",
#  "BLVDW", "BOXL", "BCLI", "BBRG", "BBEP", "BBEPP", "BDGE", "BLIN",
#  "BRID", "BCOV", "AVGO", "BSFT", "BVSN", "BYFC", "BWEN", "BRCD",
#  "BRKL", "BRKS", "BRKR", "BMTC", "BLMT", "BSQR", "BWLD", "BLDR",
#  "BUR", "CFFI", "CHRW", "CA", "CCMP", "CDNS", "CDZI", "CACQ",
#  "CZR", "CSTE", "PRSS", "CLBS", "CLMS", "CHY", "CHI", "CCD",
#  "CFGE", "CHW", "CGO", "CSQ", "CAMP", "CVGW", "CFNB", "CALA",
#  "CALD", "CALM", "CLMT", "ABCD", "CAC", "CAMT", "CSIQ",
#  "CGIX", "CPHC", "CBNJ", "CPLA", "CBF", "CCBG", "CPLP",
#  "CSWC", "CPTA", "CLAC", "CLACU", "CLACW", "CFFN", "CAPN",
#  "CAPNW", "CAPR", "CPST", "CARA", "CARB", "CBYL", "CRDC",
#  "CFNL", "CRME", "CSII", "CATM", "CDNA", "CECO", "CTRE",
#  "CKEC", "CLBH", "CARO", "CART", "CRZO", "TAST", "CRTN",
#  "CARV", "CASM", "CACB", "CSCD", "CWST", "CASY", "CASI",
#  "CASS", "CATB", "CBIO", "CPRX", "CATY", "CATYW", "CVCO",
#  "CAVM", "CBFV", "CNLM", "CNLMR", "CNLMU", "CNLMW", "CBOE",
#  "CDK", "CDW", "CECE", "CPXX", "CELG", "CELGZ", "CLDX",
#  "CLRB", "CLRBW", "CLRBZ", "CLLS", "CBMG", "CLSN", "CYAD",
#  "CEMP", "CETX", "CSFL", "CETV", "CFBK", "CENT", "CENTA",
#  "CVCY", "CFCB", "CENX", "CNBKA", "CNTY", "CPHD", "CRNT",
#  "CERC", "CERCW", "CERCZ", "CERE", "CERN", "CERU", "CERS",
#  "KOOL", "CEVA", "CSBR", "CYOU", "HOTR", "HOTRW", "CTHR",
#  "GTLS", "CHTR", "CHFN", "CHKP", "CHEK", "CHEKW", "CEMI",
#  "CHFC", "CCXI", "CHMG", "CHKE", "CHEV", "CHMA", "CBNK",
#  "PLCE", "CMRX", "CADC", "CALI", "CAAS", "CBAK", "CBPO",
#  "CCCL", "CCCR", "CCRC", "JRJC", "HGSH", "CNIT", "CJJD",
#  "HTHT", "CHNR", "CREG", "CNTF", "CXDC", "CNYD", "CCIH",
#  "CNET", "IMOS", "CDXC", "CHSCL", "CHSCM", "CHSCN", "CHSCO",
#  "CHSCP", "CHDN", "CHUY", "CDTX", "CIFC", "CMCT", "CMPR", "CINF",
#  "CIDM", "CTAS", "CPHR", "CRUS", "CSCO", "CTRN", "CZNC", "CZWI",
#  "CZFC", "CIZN", "CTXS", "CHCO", "CIVB", "CIVBP", "CDTI", "CLNE",
#  "CLNT", "CLFD", "CLRO", "CLIR", "CBLI", "CSBK", "CLVS", "CMFN",
#  "CME", "CCNE", "CISG", "CNV", "CWAY", "COBZ", "COKE", "CDRB",
#  "CDXS", "CVLY", "JVA", "CCOI", "CGNT", "CGNX", "CTSH", "COHR",
#  "CHRS", "COHU", "CLCT", "COLL", "CIGI", "CBAN", "CLCD", "COLB",
#  "COLM", "CMCO", "CBMX", "CBMXW", "CMCSA", "CBSH", "CBSHP", "CUBN",
#  "CVGI", "COMM", "CSAL", "JCS", "ESXB", "CCFI", "CYHHZ", "CTBI",
#  "CWBC", "COB", "CVLT", "CGEN", "CPSI", "CTG", "SCOR", "CHCI",
#  "CMTL", "CNAT", "CNCE", "CXRX", "CCUR", "CDOR", "CFMS", "CONG",
#  "CNFR", "CNMD", "CTWS", "CNOB", "CNXR", "CONN", "CNSL", "CWCO",
#  "CPSS", "CFRX", "CFRXW", "CTRV", "CTRL", "CPRT", "COYN", "COYNW",
#  "CRBP", "CORT", "BVA", "CORE", "CORI", "CSOD", "CRVL", "CRVS",
#  "COSI", "CSGP", "COST", "CPAH", "ICBK", "CVTI", "COVS", "COWN",
#  "COWNL", "PMTS", "CPSH", "CRAI", "CBRL", "BREW", "CACC", "GLDI",
#  "CREE", "CRESY", "CRTO", "CROX", "CCRN", "XRDC", "CRDS", "CRWS",
#  "CRWN", "CYRX", "CYRXW", "CSGS", "CCLP", "CSPI", "CSWI", "CSX",
#  "CTCM", "CTIC", "CTIB", "CTRP", "CUNB", "CUI", "CPIX", "CMLS",
#  "CRIS", "CUTR", "CVBF", "CVV", "CYAN", "CYBR", "CYBE", "CYCC", "CYCCP", "CBAY", "CYNA",
#   "CYNO", "CY", "CYRN", "CONE", "CYTK", "CTMX", "CYTX", "CTSO", "CYTR", "DJCO", "DAKT", "DAIO",
#    "DTLK", "DRAM", "DWCH", "PLAY", "DTEA", "DWSN", "DBVT", "DHRM", "DFRG", "TACO", "TACOW",
#    "DCTH", "DGAS", "DELT", "DELTW", "DENN", "XRAY", "DEPO", "DSCI", "DERM", "DEST", "DXLG",
#    "DSWL", "DTRM", "DXCM", "DHXM", "DHIL", "FANG", "DCIX", "DRNA", "DFBG", "DGII", "DMRC",
#    "DRAD", "DGLY", "APPS", "DCOM", "DMTX", "DIOD", "DPRX", "DISCA", "DISCB", "DISCK", "DISH",
#    "DVCR", "SAUC", "DLHC", "DNBF", "DLTR", "DGICA", "DGICB", "DMLP", "DORM", "EAGL", "EAGLU",
#    "EAGLW", "DDAY", "DRWI", "DRWIW", "DWA", "DRYS", "DSKX", "DSPG", "CADT", "CADTR", "CADTU",
#    "CADTW", "DTSI", "DLTH", "DNKN", "DRRX", "DXPE", "BOOM", "DYSL", "DYNT", "DVAX", "ETFC", "EBMT",
#    "EGBN", "EGLE", "EGRX", "ELNK", "EWBC", "EACQ", "EACQU", "EACQW", "EML", "EVBS", "EVGBC", "EVSTC",
#    "EVLMC", "EBAY", "EBAYL", "EBIX", "ELON", "ECHO", "ECTE", "SATS", "EEI", "ECAC", "ECACR", "ECACU", "ESES",
#    "EDAP", "EDGE", "EDGW", "EDIT", "EDUC", "EFUT", "EGAN", "EGLT", "EHTH", "EIGR", "LOCO", "EMITF", "ESLT", "ERI",
#    "ELRC", "ESIO", "EA", "EFII", "ELSE", "ELEC", "ELECU", "ELECW", "EBIO", "RDEN", "CAPX", "ESBK", "LONG", "ELTK",
#    "EMCI", "EMCF", "EMKR", "EMMS", "NYNY", "ERS", "ENTA", "ECPG", "WIRE", "ENDP", "ECYT", "ELGX", "EIGI", "WATT",
#    "EFOI", "ERII", "EXXI", "ENOC", "ENG", "ENPH", "ESGR", "ENFC", "ENTG", "ENTL", "ETRM", "EBTC", "EFSC", "EGT", "ENZN", "ENZY",
#    "EPIQ", "EPRS", "EPZM", "PLUS", "EQIX", "EQFN", "EQBK", "EAC", "ERIC", "ERIE", "ESCA", "ESMC", "ESPR", "ESSA", "EPIX", "ESND",
#    "ESSF", "ETSY", "CLWT", "EEFT", "ESEA", "EVEP", "EVK", "EVLV", "EVOK", "EVOL", "EXA", "EXAS", "EXAC", "EXEL", "EXFO", "EXLS",
#    "EXPE", "EXPD", "EXPO", "ESRX", "EXTR", "EYEG", "EYEGW", "EZPW", "FFIV", "FB", "FCS", "FRP", "FWM", "FALC", "DAVE", "FARM",
#    "FFKT", "FMNB", "FARO", "FAST", "FATE", "FBSS", "FBRC", "FDML", "FNHC", "FEIC", "FHCO", "FENX", "GSM", "FCSC", "FGEN", "ONEQ",
#    "LION", "FDUS", "FRGI", "FSAM", "FSC", "FSCFL", "FSFR", "FITB", "FITBI", "FNGN", "FISI", "FNSR", "FNJN", "FNTC", "FNTCU", "FNTCW",
#    "FEYE", "FBNC", "FNLC", "FRBA", "BUSE", "FBIZ", "FCAP", "FCFS", "FCNCA", "FCLF", "FCBC", "FCCO", "FCFP", "FBNK", "FDEF", "FFBC",
#    "FFBCW", "FFIN", "THFF", "FFNW", "FFWM", "FGBI", "INBK", "FIBK", "FRME", "FMBH", "FMBI", "FNBC", "FNFG", "FNWB", "FSFG", "FSLR",
#    "FSBK", "FPA", "BICK", "FBZ", "FCAN", "FTCS", "FCA", "FDT", "FDTS", "FVC", "FV", "IFV", "FEM", "FEMB", "FEMS", "FTSM", "FEP", "FEUZ",
#    "FGM", "FTGC", "FTHI", "HYLS", "FHK", "FTAG", "FTRI", "FPXI", "YDIV", "SKYY", "FJP", "FEX", "FTC", "FTA", "FLN", "FTLB", "LMBS", "FMB",
#    "FMK", "FNX", "FNY", "FNK", "FAD", "FAB", "MDIV", "QABA", "QCLN", "GRID", "CIBR", "CARZ", "RDVY", "FONE", "TDIV", "QQEW", "QQXT", "QTEC", "AIRR", "QINC", "RFAP", "RFDI", "RFEU", "FTSL", "FYX", "FYC", "FYT", "FKO", "FCVT", "FDIV", "FSZ", "FTW", "TUSA", "FKU", "FUNC", "SVVC", "FMER", "FSV", "FISV", "FIVE", "FPRX", "FIVN", "FLML", "FLKS", "FLXN", "SKOR", "LKOR", "MBSD", "ASET", "QLC", "FLXS", "FLEX", "FLIR", "FLDM", "FFIC", "FOMX", "FOGO", "FONR", "FES", "FORM", "FORTY", "FORR", "FTNT", "FBIO", "FWRD", "FORD", "FWP", "FOSL", "FMI", "FXCB", "FOXF", "FRAN", "FELE", "FRED", "FREE", "RAIL", "FEIM", "FRPT", "FTR", "FTRPR", "FRPH", "FSBW", "HRMN", "FTD", "FSYS", "FTEK", "FCEL", "FORK", "FULL", "FULLL", "FLL", "FULT", "FSNN", "FFHL", "GK", "WILC", "GAIA", "GLPG", "GALT", "GALTU", "GALTW", "GALE", "GLMD", "GLPI", "GPIC", "GRMN", "GGAC", "GGACR", "GGACU", "GGACW", "GARS", "GCTS", "GENC", "GNCMA", "GFN", "GFNCP", "GFNSL", "GENE", "GNMK", "GNCA", "GHDX", "GNST", "GNTX", "THRM", "GNVC", "GTWN", "GEOS", "GABC", "GERN", "GEVO", "ROCK", "GIGM", "GIGA", "GIII", "GILT", "GILD", "GBCI", "GLAD", "GLADO", "GOOD", "GOODN", "GOODO", "GOODP", "GAIN", "GAINN", "GAINO", "GAINP", "LAND", "GLBZ", "GBT", "ENT", "GBLI", "GBLIZ", "GPAC", "GPACU", "GPACW", "SELF", "GSOL", "ACTX", "QQQC", "CATH", "SOCL", "ALTY", "SRET", "YLCO", "GBIM", "GLBS", "GLRI", "GLUU", "GLYC", "GOGO", "GLNG", "GMLP", "GLDC", "GDEN", "GOGL", "GBDC", "GTIM", "GPRO", "GMAN", "GRSH", "GRSHU", "GRSHW", "GPIA", "GPIAU", "GPIAW", "LOPE", "GRVY", "GBSN", "GLDD", "GSBC", "GNBC", "GRBK", "GPP", "GPRE", "GCBC", "GLRE", "GRIF", "GRFS", "GRPN", "OMAB", "GGAL", "GSIG", "GSIT", "GSVC", "GTXI", "GBNK", "GFED", "GUID", "GIFI", "GURE", "GPOR", "GWPH", "GWGH", "GYRO", "HEES", "HLG", "HNRG", "HALL", "HALO", "HBK", "HMPR", "HBHC", "HBHCL", "HNH", "HAFC", "HNSN", "HQCL", "HDNG", "HLIT", "HRMNU", "HRMNW", "TINY", "HBIO", "HCAP", "HCAPL", "HAS", "HA", "HCOM", "HWKN", "HWBK", "HAYN", "HDS", "HIIQ", "HCSG", "HQY", "HSTM", "HWAY", "HTLD", "HTLF", "HTWR", "HTBX", "HSII", "HELE", "HMNY", "HMTV", "HNNA", "HCAC", "HCACU", "HCACW", "HSIC", "HERO", "HTBK", "HFWA", "HEOP", "HCCI", "MLHR", "HRTX", "HSKA", "HFFC", "HIBB", "HPJ", "HIHO", "HIMX", "HIFS", "HSGX", "HMNF", "HMSY", "HOLI", "HOLX", "HBCP", "HOMB", "HFBL", "HMST", "HTBI", "CETC", "HOFT", "HFBC", "HBNC", "HZNP", "HRZN", "HDP", "HMHC", "HWCC", "HOVNP", "HBMD", "HSNI", "HTGM", "HUBG", "HSON", "HDSN", "HBAN", "HBANO", "HBANP", "HURC", "HURN", "HTCH", "HCM", "HBP", "HDRA", "HDRAR", "HDRAU", "HDRAW", "HYGS", "IDSY", "IAC", "IKGH", "IBKC", "IBKCP", "ICAD", "IEP", "ICFI", "ICLR", "ICON", "ICUI", "IPWR", "INVE", "IDRA", "IDXX", "DSKY", "IROQ", "IRG", "RXDX", "IIVI", "KANG", "IKNX", "ILMN", "ISNS", "IMMR", "ICCC", "IMDZ", "IMNP          ", "IMGN", "IMMU", "IPXL", "IMMY", "INCR", "SAAS", "INCY", "INDB", "IBCP", "IBTX", "IDSA", "INFN", "INFI", "IPCC", "III", "IFON", "IMKTA", "INWK", "INNL", "INOD", "IPHS", "IOSP", "ISSC", "INVA", "INGN", "ITEK", "INOV", "INO", "NSIT", "ISIG", "INSM", "IIIN", "PODD", "INSY", "NTEC", "IART", "IDTI", "IESC", "INTC", "IQNT", "IPCI", "IPAR", "IBKR", "ININ", "ICPT", "ICLD", "ICLDW", "IDCC", "TILE", "LINK", "IMI", "INAP", "IBOC", "ISCA", "IGLD", "IIJI", "IDXG", "XENT", "INTX", "ISIL", "IILG", "IILGV", "IVAC", "INTL", "INTLL", "ITCI", "IIN", "INTU", "ISRG", "INVT", "SNAK", "ISTR", "ISBC", "ITIC", "NVIV", "IVTY", "IONS", "IPAS", "IPGP", "IRMD", "IRIX", "IRDM", "IRDMB", "IRBT", "IRWD", "IRCP", "SLQD", "TLT", "AIA", "COMT", "IXUS", "IFEU", "IFGL", "IGF", "GNMA", "JKI", "ACWX", "ACWI", "AAXJ", "EWZS", "MCHI", "SCZ", "EEMA", "EEML", "EUFN", "IEUS", "ENZL", "QAT", "UAE", "IBB", "SOXX", "EMIF", "ICLN", "WOOD", "INDY", "ISHG", "IGOV", "MPCT", "ISLE", "ISRL", "ITI", "ITRI", "ITRN", "ITUS", "XXIA", "IXYS", "IZEA", "JJSF", "MAYS", "JBHT", "JCOM", "JASO", "JKHY", "JACK", "JXSB", "JAGX", "JAKK", "JMBA", "JRVR", "JSML", "JSMD", "JASN", "JASNW", "JAZZ", "JD", "JSYNU", "JBLU", "JTPY", "JCTCF", "DATE", "JIVE", "WYIG", "WYIGU", "WYIGW", "JBSS", "JOUT", "JNP", "JUNO", "KTWO", "KALU", "KMDA", "KNDI", "KPTI", "KBSF", "KCAP", "KRNY", "KELYA", "KELYB", "KMPH", "KFFB", "KERX", "KEQU", "KTEC", "KTCC", "KFRC", "KE", "KBAL", "KIN", "KGJI", "KINS", "KONE", "KIRK", "KITE", "KTOV", "KTOVW", "KLAC", "KLRE", "KLREU", "KLREW", "KLXI", "KONA", "KZ", "KOPN", "KRNT", "KOSS", "KWEB", "KTOS", "KUTV", "KLIC", "KURA", "KVHI", "FSTR", "LJPC", "DRIO", "DRIOW", "LSBK", "LSBG", "LBAI", "LKFN", "LAKE", "LRCX", "LAMR", "LANC", "LNDC", "LARK", "LMRK", "LE", "LSTR", "LNTH", "LTRX", "LPSB", "LSCC", "LAWS", "LAYN", "LCNB", "LDRH", "LBIX", "LGCY", "LGCYO", "LGCYP", "LTXB", "DDBI", "EDBI", "LVHD", "UDBI", "LMAT", "TREE", "LXRX", "LGIH", "LHCG", "LBRDA", "LBRDK", "LBTYA", "LBTYB", "LBTYK", "LILA", "LILAK", "LVNTA", "LVNTB", "QVCA", "QVCB", "BATRA", "BATRK", "LMCA", "LMCK", "LSXMA", "LSXMB", "LSXMK", "TAX", "LTRPA", "LTRPB", "LPNT", "LCUT", "LFVN", "LWAY", "LGND", "LTBR", "LPTH", "LLEX", "LIME", "LLNW", "LMNR", "LINC", "LECO", "LIND", "LINDW", "LLTC", "LNCO", "LINE", "LBIO", "LIOX", "LPCN", "LQDT", "LFUS", "LIVN", "LOB", "LIVE", "LPSN", "LKQ", "LMFA", "LMFAW", "LMIA", "LOGI", "LOGM", "EVAR", "CNCR", "LORL", "LOXO", "LPTN", "LPLA", "LRAD", "LYTS", "LULU", "LITE", "LMNX", "LMOS", "LUNA", "MBTF", "MTSI", "MCBC", "MFNC", "MCUR", "MGNX", "MAGS", "MGLN", "MPET", "MGIC", "CALL", "MNGA", "MGYR", "MHLD", "MHLDO", "MSFG", "COOL", "MMYT", "MBUU", "MLVF", "MAMS", "MANH", "LOAN", "MNTX", "MTEX", "MNKD", "MANT", "MAPI", "MARA", "MCHX", "MARPS", "MRNS", "BBH", "GNRX", "PPH", "MKTX", "MKTO", "MRKT", "MRLN", "MAR", "MBII", "MRTN", "MMLP", "MRVL", "MASI", "MTCH", "MTLS", "MTRX", "MAT", "MATR", "MATW", "MFRM", "MTSN", "MXIM", "MXWL", "MZOR", "MBFI", "MBFIP", "MCFT", "MGRC", "MDCA", "TAXI", "TAXIL", "MTBC", "MTBCP", "MNOV", "MDSO", "MDGS", "MDVN", "MDWD", "MDVX", "MDVXW", "MEET", "MEIP", "MPEL", "MLNX", "MELR", "MEMP", "MRD", "MENT", "MTSL", "MELI", "MBWM", "MERC", "MBVT", "MRCY", "EBSB", "VIVO", "MMSI", "MACK", "MSLI", "MLAB", "MESO", "CASH", "MBLX", "MEOH", "MFRI", "MGCD", "MGEE", "MGPI", "MCHP", "MU", "MICT", "MICTW", "MSCC", "MSFT", "MSTR", "MVIS", "MPB", "MTP", "MCEP", "MBRG", "MBCN", "MSEX", "MOFG", "MIME", "MDXG", "MNDO", "MB", "NERV", "MRTX", "MIRN", "MSON", "MIND", "MITK", "MITL", "MKSI", "MMAC", "MINI", "MOBL", "MOCO", "MDSY", "MLNK", "MOKO", "MNTA", "MOMO", "MCRI", "MNRK", "MDLZ", "MGI", "MPWR", "TYPE", "MNRO", "MRCC", "MNST", "MHGC", "MORN", "MOSY", "MPAA", "MDM", "MRVC", "MSBF", "MSG", "MTSC", "LABL", "MFLX", "MFSF", "MYL", "MYOK", "MYOS", "MYRG", "MYGN", "NBRV", "NAKD", "NNDM", "NANO", "NSPH", "NSTG", "NK", "NSSC", "NDAQ", "NTRA", "NATH", "NAUH", "NKSH", "FIZZ", "NCMI", "NCOM", "NGHC", "NGHCO", "NGHCP", "NGHCZ", "NHLD", "NATI", "NATL", "NRCIA", "NRCIB", "NSEC", "NWLI", "NAII", "NHTC", "NATR", "BABY", "NAVI", "NBCP", "NBTB", "NCIT", "NKTR", "NEOG", "NEO", "NEON", "NEOS", "NEOT", "NVCN", "NRX", "NEPT", "UEPS", "NETE", "NTAP", "NTES", "NFLX", "NTGR", "NLST", "NTCT", "NTWK", "CUR", "NBIX", "NDRM", "NURO", "NUROW", "NSIG", "NYMT", "NYMTO", "NYMTP", "NLNK", "NEWP", "NWS", "NWSA", "NEWS", "NEWT", "NEWTZ", "NXST", "NVET", "NFEC", "EGOV", "NICE", "NICK", "NCBS", "NIHD", "NVLS", "NMIH", "NNBR", "NDLS", "NORT", "NDSN", "NSYS", "NTK", "NBN", "NTIC", "NTRS", "NTRSP", "NFBK", "NRIM", "NWBI", "NWBO", "NWBOW", "NWPX", "NCLH", "NWFL", "NVFY", "NVMI", "NVDQ", "MIFI", "NVAX", "NVCR", "NVGN", "NTLS", "NUAN", "NMRX", "NUTR", "NTRI", "NUVA", "NVTR", "QQQX", "NVEE", "NVEC", "NVDA", "NXPI", "NXTM", "NXTD", "NXTDW", "NYMX", "OIIM", "OVLY", "OASM", "OBCI", "OPTT", "ORIG", "OSHC", "OCFC", "OCRX", "OCLR", "OFED", "OCUL", "OCLS", "OCLSW", "OMEX", "ODP", "OFS", "OHAI", "OVBC", "OHRP", "ODFL", "OLBK", "ONB", "OPOF", "OSBC", "OSBCP", "OLLI", "ZEUS", "OFLX", "OMER", "OMCL", "ON", "OTIV", "OGXI", "OMED", "ONTX", "ONCS", "ONTY", "OHGI", "ONVI", "OTEX", "OPXA", "OPXAW", "OPGN", "OPGNW", "OPHT", "OBAS", "OCC", "OPHC", "OPB", "ORMP", "OSUR", "ORBC", "ORBK", "ORLY", "OREX", "SEED", "OESX", "ORIT", "ORRF", "OFIX", "OSIS", "OSIR", "OSN", "OTEL", "OTG", "OTIC", "OTTR", "OUTR", "OVAS", "OSTK", "OXBR", "OXBRW", "OXFD", "OXLC", "OXLCN", "OXLCO", "OXGN", "PFIN", "PTSI", "PCAR", "PACE", "PACEU", "PACEW", "PACB", "PCBK", "PEIX", "PMBC", "PPBI", "PAAC", "PAACR", "PAACU", "PAACW", "PCRX", "PACW", "PTIE", "PAAS", "PNRA", "PANL", "PZZA", "FRSH", "PRGN", "PRGNL", "PRTK", "PRXL", "PCYG", "PSTB", "PKBK", "PRKR", "PKOH", "PARN", "PTNR", "PBHC", "PATK", "PNBK", "PATI", "PEGI", "PDCO", "PTEN", "PAYX", "PCTY", "PYDS", "PYPL", "PBBI", "PCCC", "PCMI", "PCTI", "PDCE", "PDFS", "PDLI", "PDVW", "SKIS", "PGC", "PEGA", "PCO", "PENN", "PFLT", "PNNT", "PWOD", "PTXP", "PEBO", "PEBK", "PFBX", "PFIS", "PBCT", "PUB", "PRCP", "PPHM", "PPHMP", "PRFT", "PFMT", "PERF", "PERI", "PESI", "PTX", "PERY", "PGLC", "PETS", "PFSW", "PGTI", "PHII", "PHIIK", "PAHC", "PHMD", "PLAB", "PICO", "PIRS", "PPC", "PME", "PNK", "PNKZV", "PNFP", "PPSI", "PXLW", "PLPM", "PLXS", "PLUG", "PLBC", "PSTI", "PLXP", "PMV", "PBSK", "PNTR", "PCOM", "PLCM", "POOL", "POPE", "PLKI", "BPOP", "BPOPM", "BPOPN", "PBIB", "PTLA", "PBPB", "PCH", "POWL", "POWI", "PSIX", "PDBC", "DWIN", "DWTR", "IDLB", "PRFZ", "PAGG", "PSAU", "IPKW", "LDRI", "LALT", "PNQI", "QQQ", "USLB", "PSCD", "PSCC", "PSCE", "PSCF", "PSCH", "PSCI", "PSCT", "PSCM", "PSCU", "PRAA", "PRAH", "PRAN", "PFBC", "PLPC", "PFBI", "PINC", "LENS", "PRGX", "PSMT", "PBMD", "PNRG", "PRMW", "PRIM", "PSET", "PY", "PRZM", "PVTB", "PVTBP", "PDEX", "IPDN", "PFIE", "PGNX", "PRGS", "DNAI", "PFPT", "PRPH", "PRQR", "BIB", "UBIO", "TQQQ", "ZBIO", "SQQQ", "BIS", "PSEC", "PRTO", "PTI", "PRTA", "PWX", "PVBC", "PROV", "PBIP", "PSDV", "PMD", "PTC", "PTCT", "PULB", "PULM", "PCYO", "PXS", "QADA", "QADB", "QCRH", "QGEN", "QIWI", "QKLS", "QLIK", "QLGC", "QLTI", "QRVO", "QCOM", "QSII", "QBAK", "QLYS", "QRHC", "QUIK", "QDEL", "QPAC", "QPACU", "QPACW", "QNST", "QUMU", "QUNR", "QTNT", "RRD", "RADA", "RDCM", "ROIA", "ROIAK", "RSYS", "RDUS", "RDNT", "RDWR", "RMBS", "RAND", "RLOG", "GOLD", "RPD", "RPTP", "RAVE", "RAVN", "ROLL", "RICK", "RCMT", "RLOC", "RDI", "RDIB", "RGSE", "RELY", "RNWK", "RP", "UTES", "DAX", "QYLD", "RCON", "REPH", "RRGB", "RDHL", "REDF", "REGN", "RGNX", "DFVL", "DFVS", "DGLD", "DLBL", "DLBS", "DSLV", "DTUL", "DTUS", "DTYL", "DTYS", "FLAT", "SLVO", "STPP", "TAPR", "TVIX", "TVIZ", "UGLD", "USLV", "VIIX", "VIIZ", "XIV", "ZIV", "RGLS", "REIS", "RELV", "RLYP", "MARK", "RNST", "REGI", "RNVA", "RNVAW", "RCII", "RTK", "RGEN", "RPRX", "RBCAA", "FRBK", "RSAS", "REFR", "RESN", "REXI", "RECN", "ROIC", "SALE", "RTRX", "RVNC", "RBIO", "RVLT", "RWLK", "REXX", "RFIL", "RGCO", "RIBT", "RIBTW", "RELL", "RIGL", "NAME", "RNET", "RITT", "RITTW", "RTTR", "RVSB", "RLJE", "RMGN", "ROBO", "FUEL", "RMTI", "RCKY", "RMCF", "RSTI", "ROKA", "ROSG", "ROST", "ROVI", "RBPAA", "RGLD", "RPXC", "RRM", "RTIX", "RBCN", "RUSHA", "RUSHB", "RUTH", "RXII", "RYAAY", "STBA", "SANW", "SBRA", "SBRAP", "SABR", "SAEX", "SAFT", "SAGE", "SGNT", "SAIA", "SAJA", "SALM", "SAL", "SAFM", "SNDK", "SASR", "SGMO", "SANM", "GCVRZ", "SPNS", "SRPT", "SBFG", "SBFGP", "SBAC", "SCSC", "SMIT", "SCHN", "SCHL", "SCLN", "SGMS", "SQI", "SNI", "SCYX", "SEAC", "SBCF", "STX", "SHIP", "SRSC", "SHLD", "SHLDW", "SHOS", "SPNE", "SGEN", "EYES", "SCWX", "SNFCA", "SEIC", "SLCT", "SCSS", "SIGI", "LEDS", "SMLR", "SMTC", "SENEA", "SENEB", "SNMX", "SRTS", "SQNM", "SQBG", "MCRB", "SREV", "SFBS", "SEV", "SVBI", "SGOC", "SMED", "SHSP", "SHEN", "SHLO", "SCCI", "SHPG", "SCVL", "SHBI", "SHOR", "SFLY", "SIFI", "SIEB", "SIEN", "BSRR", "SWIR", "SIFY", "SIGM", "SGMA", "SGNL", "SBNY", "SBNYW", "SLGN", "SILC", "SGI", "SLAB", "SIMO", "SPIL", "SRAQ", "SRAQU", "SRAQW", "SSRI", "SAMG", "SFNC", "SLP", "SINA", "SBGI", "SINO", "SVA", "SIRI", "SRVA", "SITO", "SZMK", "SKUL", "SKYS", "SKLN", "MOBI", "SPU", "SKYW", "SWKS", "ISM", "JSM", "OSM", "SLM", "SLMAP", "SLMBP", "SMT", "SMBK", "SWHC", "SMSI", "SMTX", "LNCE", "SODA", "SOHU", "SLRC", "SUNS", "SCTY", "SEDG", "SZYM", "SONC", "SOFO", "SONS", "SPHS", "SORL", "SRNE", "SOHO", "SOHOL", "SOHOM", "SFBC", "SSB", "SOCB", "SFST", "SMBC", "SONA", "SBSI", "OKSB", "SP", "SPAN", "SBSA", "SGRP", "SPKE", "ONCE", "SPAR", "SPTN", "SPPI", "ANY", "SPEX", "SPI", "SAVE", "SPLK", "SPOK", "SPWH", "SBPH", "FUND", "SFM", "SPSC", "SSNC", "STAA", "STAF", "STMP", "STLY", "SPLS", "SBLK", "SBLKL", "SBUX", "STRZA", "STRZB", "STFC", "STBZ", "SNC", "STDY", "GASS", "STLD", "SMRT", "SBOT", "STEM", "STML", "STXS", "SRCL", "SRCLP", "STRL", "SHOO", "SSFN", "SYBT", "BANX", "SGBK", "SSKN", "SSYS", "STRT", "STRS", "STRA", "STRM", "SBBP", "STB", "SCMP", "SUMR", "SMMF", "SSBI", "SMMT", "SNBC", "SNHY", "SNDE", "SEMI", "SNSS", "STKL", "SPWR", "RUN", "SBCP", "SSH", "SUNW", "SMCI", "SPCB", "SCON", "SGC", "SUPN", "SPRT", "SGRY", "SCAI", "SRDX", "SBBX", "SIVB", "SIVBO", "SYKE", "SYMC", "SSRG", "SYNC", "SYNL", "SYNA", "SNCR", "SNDX", "SGYP", "SGYPU", "SGYPW", "ELOS", "SNPS", "SNTA", "SYNT", "SYMX", "SYUT", "SYPR", "SYRX", "TROW", "TTOO", "TAIT", "TTWO", "TLMR", "TNDM", "TLF", "TNGO", "TANH", "TEDU", "TASR", "TATT", "TAYD", "TCPC", "AMTD", "TEAR", "TECD", "TCCO", "TTGT", "TGLS", "TGEN", "TNAV", "TTEC", "TLGT", "TENX", "GLBL", "TERP", "TRTL", "TRTLU", "TRTLW", "TBNK", "TSRO", "TESO", "TSLA", "TESS", "TSRA", "TTEK", "TLOG", "TTPH", "TCBI", "TCBIL", "TCBIP", "TCBIW", "TXN", "TXRH", "TFSL", "TGTX", "ABCO", "ANDE", "TBBK", "BONT", "CG", "CAKE", "CHEF", "TCFC", "DSGX", "DXYN", "ENSG", "XONE", "FINL", "FBMS", "FLIC", "TFM", "GT", "HABT", "HCKT", "HAIN", "CUBA", "INTG", "JYNT", "KEYW", "KHC", "MDCO", "MIK", "MIDD", "NAVG", "STKS", "PCLN", "PRSC", "BITE", "RMR", "SPNC", "ULTI", "YORW", "NCTY", "TBPH", "TST", "TCRD", "THLD", "TICC", "TTS", "TIL", "TSBK", "TIPT", "TITN", "TTNP", "TIVO", "TMUS", "TMUSP", "TBRA", "TKAI", "TNXP", "TISA", "TOPS", "TORM          ", "TRCH", "TSEM", "TWER", "CLUB", "TOWN", "TCON", "TSCO", "TWMC", "TACT", "TRNS", "TBIO", "TGA", "TTHI", "TZOO", "TRVN", "TCBK", "TRIL", "TRS", "TRMB", "TRIB", "TRIP", "TSC", "TBK", "TROV", "TROVU", "TROVW", "TRUE", "THST", "TRST", "TRMK", "TSRI", "TTMI", "TUBE", "TCX", "TUES", "TOUR", "HEAR", "TUTI", "TUTT", "FOX", "FOXA", "TWIN", "TRCB", "USCR", "PRTS", "USEG", "GROW", "UREE", "UBIC", "UBNT", "UFPT", "ULTA", "UCTT", "RARE", "ULBI", "ULTR", "UTEK", "UMBF", "UMPQ", "UNAM", "UNIS", "UBSH", "UNB", "UNXL", "QURE", "UBCP", "UBOH", "UBSI", "UCBA", "UCBI", "UCFC", "UDF", "UBNK", "UFCS", "UIHC", "UNFI", "UNTD", "UBFO", "USBI", "USLM", "UTHR", "UG", "UNTY", "OLED", "UEIC", "UFPI", "USAP", "UACL", "UVSP", "UPIP", "UPLD", "URRE", "URBN", "ECOL", "USAT", "USATP", "USAK", "USMD", "UTMD", "UTSI", "VALX", "VALU", "VNDA", "VWOB", "VNQI", "VGIT", "VCIT", "VIGI", "VYMI", "VCLT", "VGLT", "VMBS", "VNR", "VNRAP", "VNRBP", "VNRCP", "VONE", "VONG", "VONV", "VTWO", "VTWG", "VTWV", "VTHR", "VCSH", "VGSH", "VTIP", "BNDX", "VXUS", "VRNS", "VDSI", "VBLT", "VASC", "VBIV", "WOOF", "VECO", "APPY", "VRA", "VCYT", "VSTM", "VCEL", "VRNT", "VRSN", "VRSK", "VBTX", "VRML", "VSAR", "VTNR", "VRTX", "VRTB", "VIA", "VIAB", "VSAT", "VIAV", "VICL", "VICR", "CIZ", "CEZ", "CID", "CIL", "CFO", "CFA", "CSF", "CDC", "CDL", "CSB", "CSA", "VBND", "VUSE", "VIDI", "VDTH", "VRAY", "VKTX", "VKTXW", "VBFC", "VLGEA", "VIP", "VNOM", "VIRC", "VA", "VIRT", "VSCP", "VRTS", "VRTU", "VISN", "VTAE", "VTL", "VVUS", "VOD", "VLTC", "VOXX", "VYGR", "VRNG", "VSEC", "VTVT", "VUZI", "VWR", "WGBS", "WBA", "WRES", "WAFD", "WAFDW", "WASH", "WFBI", "WSBF", "WVE", "WNFM", "WAYN", "WSTG", "WDFC", "FLAG", "WEB", "WBMD", "WB", "WEBK", "WEN", "WERN", "WSBC", "WTBA", "WSTC", "WMAR", "WABC", "WBB", "WSTL", "WDC", "WFD", "WLB", "WPRT", "WEYS", "WHLR", "WHLRP", "WHLRW", "WHF", "WHFBL", "WFM", "WILN", "WHLM", "WVVI", "WVVIP", "WLDN", "WLFC", "WLTW", "WIBC", "WIN", "WINT", "WING", "WINA", "WINS", "WTFC", "WTFCM", "WTFCW", "AGND", "AGZD", "HYND", "HYZD", "CXSE", "EMCG", "EMCB", "DGRE", "DXGE", "WETF", "DXJS", "JGBB", "DXKW", "GULF", "CRDT", "DGRW", "DGRS", "DXPS", "UBND", "WIX", "WLRH", "WLRHU", "WLRHW", "WMIH", "WBKC", "WWD", "WKHS", "WRLD", "WOWO", "WPCS", "WPPGY", "WMGI", "WMGIZ", "WSFS", "WSFSL", "WSCI", "WVFC", "WYNN", "XBIT", "XELB", "XCRA", "XNCR", "XBKS", "XENE", "XNPT", "XGTI", "XGTIW", "XLNX", "XOMA", "XPLR", "XCOM", "XTLB", "XNET", "MESG", "YHOO", "YNDX", "YOD", "YCB", "YRCW", "YECO", "YY", "ZFGN", "ZAGG", "ZAIS", "ZBRA", "ZLTQ", "ZHNE",
#  "Z", "ZG", "ZN", "ZNWAA", "ZION", "ZIONW", "ZIONZ", "ZIOP", "ZIXI", "ZGNX", "ZSAN", "ZUMZ", "ZYNE", "ZNGA"]




#Test for chart data
    # @all_dates = dates("2015/01/01", "2015/01/09")

    # @json1 = [{"date" => "", "adj_close"=> "", "change"=>"", "value"=>100, "year"=>2015, "month"=>0, "day"=>1},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>95, "year"=>2015, "month"=>0, "day"=>2},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>90, "year"=>2015, "month"=>0, "day"=>3},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>85, "year"=>2015, "month"=>0, "day"=>4},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>75, "year"=>2015, "month"=>0, "day"=>6},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>70, "year"=>2015, "month"=>0, "day"=>7},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>65, "year"=>2015, "month"=>0, "day"=>8},
    # {"date" => "", "adj_close"=> "", "change"=>"", "value"=>60, "year"=>2015, "month"=>0, "day"=>9}]

    # @json2 = [{"date" => "", "adj_close"=> "", "change"=>"", "value"=>100, "year"=>2015, "month"=>0, "day"=>1},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>90, "year"=>2015, "month"=>0, "day"=>3},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>85, "year"=>2015, "month"=>0, "day"=>4},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>80, "year"=>2015, "month"=>0, "day"=>5},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>75, "year"=>2015, "month"=>0, "day"=>6},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>70, "year"=>2015, "month"=>0, "day"=>7},
    # {"date" => "", "adj_close"=> "", "change"=>"", "value"=>60, "year"=>2015, "month"=>0, "day"=>9}]

    # @json3 = [{"date" => "", "adj_close"=> "", "change"=>"", "value"=>100, "year"=>2015, "month"=>0, "day"=>1},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>95, "year"=>2015, "month"=>0, "day"=>2},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>90, "year"=>2015, "month"=>0, "day"=>3},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>85, "year"=>2015, "month"=>0, "day"=>4},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>80, "year"=>2015, "month"=>0, "day"=>5},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>75, "year"=>2015, "month"=>0, "day"=>6},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>70, "year"=>2015, "month"=>0, "day"=>7},
    #   {"date" => "", "adj_close"=> "", "change"=>"", "value"=>65, "year"=>2015, "month"=>0, "day"=>8},
    # {"date" => "", "adj_close"=> "", "change"=>"", "value"=>60, "year"=>2015, "month"=>0, "day"=>9}]

    # @date1 = date_array(@json1)
    # @date2 = date_array(@json2)
    # @date3 = date_array(@json3)

    # value1 = value_array(@json1)
    # value2 = value_array(@json2)
    # value3 = value_array(@json3)

    # @missing_date1 = compare_json_dates_range_dates(@date1, @all_dates)
    # create_value(@missing_date1, value1)
    # @missing_date2 = compare_json_dates_range_dates(@date2, @all_dates)
    # create_value(@missing_date2, value2)
    # @missing_date3 = compare_json_dates_range_dates(@date3, @all_dates)
    # create_value(@missing_date3, value3)

    # allocated1 = value_allocation(value1,33.33)
    # allocated2 = value_allocation(value2,33.33)
    # allocated3 = value_allocation(value3,33.33)

    # @stocks_values << allocated1
    # @stocks_values << allocated2
    # @stocks_values << allocated3

