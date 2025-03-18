SELECT data1.division_id ,
  data1.division_site_id ,
  data1.merchant_descriptor AS site_name ,
  data1.sales_units ,
  data1.cb_units ,
  (data1.cb_units/data1.sales_units)unit_cbr ,
  data1.sales_amount ,
  data1.cb_amount ,
  (data1.cb_amount             /data1.sales_amount) amount_cbr ,
  (data1.cb_units              /plat_data2.units) RATIO_TOTAL_PLATFORM_CB_UNITS ,
  (data1.cb_amount             /plat_data2.amount) RATIO_TOTAL_PLATFORM_CB_AMOUNT ,
  (data1.cb_units              /global_data.units)RATIO_GLOBAL_CB_UNITS ,
  (data1.cb_amount             /global_data.amount)RATIO_GLOBAL_CB_amount ,
  data1.num_fraud              /DECODE(data1.cb_units,0,NULL,data1.cb_units)num_fraud ,
  data1.num_misc_cs            /DECODE(data1.cb_units,0,NULL,data1.cb_units)num_misc_cs ,
  data1.num_unrec              /DECODE(data1.cb_units,0,NULL,data1.cb_units)num_unrec ,
  data1.num_not_received       /DECODE(data1.cb_units,0,NULL,data1.cb_units)num_not_recognized ,
  data1.num_cancel_recurring   /DECODE(data1.cb_units,0,NULL,data1.cb_units)cancel_recurring ,
  data1.num_not_as_described   /DECODE(data1.cb_units,0,NULL,data1.cb_units)not_as_described ,
  data1.num_no_credit          /DECODE(data1.cb_units,0,NULL,data1.cb_units)num_no_credit ,
  data1.num_defective          /DECODE(data1.cb_units,0,NULL,data1.cb_units)num_defective ,
  data1.num_duplicate          /DECODE(data1.cb_units,0,NULL,data1.cb_units)num_duplicate ,
  data1.num_auth               /DECODE(data1.cb_units,0,NULL,data1.cb_units)num_auth ,
  data1.amount_fraud           /DECODE(data1.cb_amount,0,NULL,data1.cb_amount)amount_fraud ,
  data1.amount_misc_cs         /DECODE(data1.cb_amount,0,NULL,data1.cb_amount)amount_misc_cs ,
  data1.amount_unrec           /DECODE(data1.cb_amount,0,NULL,data1.cb_amount)amount_unrec ,
  data1.amount_not_received    /DECODE(data1.cb_amount,0,NULL,data1.cb_amount)amount_not_recognized ,
  data1.amount_cancel_recurring/DECODE(data1.cb_amount,0,NULL,data1.cb_amount)cancel_recurring ,
  data1.amount_not_as_described/DECODE(data1.cb_amount,0,NULL,data1.cb_amount)not_as_described ,
  data1.amount_no_credit       /DECODE(data1.cb_amount,0,NULL,data1.cb_amount)amount_no_credit ,
  data1.amount_defective       /DECODE(data1.cb_amount,0,NULL,data1.cb_amount)amount_defective ,
  data1.amount_duplicate       /DECODE(data1.cb_amount,0,NULL,data1.cb_amount)amount_duplicate ,
  data1.amount_auth            /DECODE(data1.cb_amount,0,NULL,data1.cb_amount)amount_auth ,
  DECODE(data1.division_id,'swreg','globalDirect','regnow','globalDirect','regnet','globalDirect','setsystems','globalDirect','esellerate','globalDirect','ccnow','globalDirect','regsoft','globalDirect',( DECODE(data1.division_site_id, '4' , 'Software-US', '7' , 'Software-US', '19' , 'Software-US', '20' , 'Software-US', '24' , 'Software-US', '25' , 'Software-US', '29' , 'Software-US', '30' , 'Software-US', '33' , 'Software-US', '40' , 'Software-US', '52' , 'Software-US', '53' , 'Software-US', '55' , 'Software-US', '61' , 'Software-US', '69' , 'Software-US', '77' , 'Software-US', '83' , 'Software-US', '87' , 'Software-US', '100' , 'CE-US', '106' , 'CE-US', '108' , 'CE-US', '113' , 'Software-US', '118' , 'CE-US', '121' , 'CE-US', '124' , 'Software-US', '125' , 'CE-US', '126' , 'Software-US', '128' , 'CE-US', '133' , 'CE-US', '138' , 'Software-US', '139' , 'CE-US', '150' , 'CE-US', '151' , 'CE-US', '153' , 'Software-US', '155' , 'Software-US', '157' , 'CE-US', '165' , 'Software-US',
  '167' , 'Software-US', '206' , 'CE-US', '211' , 'CE-US', '223' , 'Software-US', '225' , 'CE-US', '238' , 'Software-US', '240' , 'Software-US', '270' , 'Software-US', '272' , 'Software-US', '273' , 'Software-US', '281' , 'Software-US', '296' , 'Software-US', '299' , 'CE-US', '302' , 'Gaming-US', '305' , 'CE-US', '314' , 'Software-US', '319' , 'CE-US', '324' , 'Software-US', '326' , 'CE-US', '333' , 'Software-US', '349' , 'CE-US', '358' , 'Software-US', '371' , 'Software-US', '399' , 'Software-US', '400' , 'Software-US', '422' , 'Software-US', '427' , 'Software-US', '468' , 'Software-US', '471' , 'Software-US', '483' , 'CE-EMEA', '484' , 'CE-EMEA', '485' , 'CE-EMEA', '486' , 'CE-US', '498' , 'Software-US', '520' , 'Software-US', '524' , 'Software-US', '525' , 'Software-US', '526' , 'CE-EMEA', '528' , 'CE-EMEA', '529' , 'CE-EMEA', '536' , 'Software-US', '542' , 'Software-US', '546' , 'Software-US', '547' , 'CE-US', '548' , 'CE-US', '553' , 'Software-US', '564' , 'Software-US', '608' ,
  'Software-US', '632' , 'Software-US', '651' , 'Software-US', '653' , 'Software-US', '679' , 'Software-US', '701' , 'Software-US', '748' , 'Software-US', '773' , 'Software-US', '849' , 'Software-US', '895' , 'Software-US', '914' , 'Software-US', '1007' , 'Software-US', '1023' , 'Software-US', '1058' , 'Software-US', '1106' , 'Software-US', '1107' , 'Software-US', '1109' , 'Software-US', '1124' , 'Software-US', '1131' , 'Software-US', '1317' , 'Software-US', '1318' , 'Software-US', '1347' , 'Software-US', '1349' , 'Software-US', '1382' , 'Software-US', '1477' , 'Software-US', '1478' , 'Software-US', '1592' , 'Software-US', '1633' , 'Software-US', '1839' , 'Software-US', '2579' , 'Software-US', '2801' , 'Software-US', '2888' , 'Software-US', '3434' , 'Software-US', '3468' , 'Software-US', '3528' , 'Software-US', '5111' , 'Software-US', '5152' , 'Software-US', '5410' , 'Software-US', '5500' , 'CE-EMEA', '5793' , 'Software-US', '5933' , 'Software-US', '6211' , 'Software-US', '6619' ,
  'Software-US', '6721' , 'Software-US', '7144' , 'Software-US', '7438' , 'Software-US', '7579' , 'Software-US', '7635' , 'Software-US', '7674' , 'Software-US', '7675' , 'Software-US', '7855' , 'Software-US', '8119' , 'Software-US', '8278' , 'Software-US', '8282' , 'Software-US', '8318' , 'Software-US', '8379' , 'Software-US', '8593' , 'Software-US', '8619' , 'Software-US', '8658' , 'Software-US', '8779' , 'Software-US', '9087' , 'Software-US', '9278' , 'Software-US', '9280' , 'Software-US', '9765' , 'Software-US', '9948' , 'Software-US', '10045' , 'Software-US', '10143' , 'Software-EMEA', '10149' , 'Software-EMEA', '10371' , 'Software-EMEA', '10441' , 'Software-EMEA', '10699' , 'Software-EMEA', '10769' , 'Software-US', '10773' , 'Software-EMEA', '10992' , 'Software-EMEA', '11048' , 'Software-US', '11255' , 'Software-US', '11395' , 'Software-EMEA', '11469' , 'Software-US', '11743' , 'Software-EMEA', '13528' , 'Software-US', '13950' , 'Software-EMEA', '13958' , 'Software-EMEA',
  '14524' , 'Software-EMEA', '14603' , 'Software-EMEA', '14919' , 'Software-EMEA', '14925' , 'Software-EMEA', '15288' , 'Software-US', '15289' , 'Software-EMEA', '15376' , 'Software-US', '15453' , 'Software-EMEA', '15628' , 'Software-US', '15668' , 'Software-US', '15926' , 'Software-EMEA', '16269' , 'Software-US', '16348' , 'Software-US', '16428' , 'Software-US', '16537' , 'Software-EMEA', '16538' , 'Software-EMEA', '16588' , 'Software-US', '16808' , 'Software-US', '16926' , 'Software-EMEA', '17013' , 'Software-US', '17075' , 'Software-EMEA', '17549' , 'Software-US', '17648' , 'Software-US', '17813' , 'Software-US', '17852' , 'Software-US', '17912' , 'Software-US', '17929' , 'Software-EMEA', '18052' , 'Software-US', '18192' , 'Software-US', '18202' , 'Software-EMEA', '18212' , 'Software-US', '18332' , 'Software-US', '18446' , 'Software-US', '18508' , 'Software-EMEA', '18628' , 'Software-US', '18633' , 'Software-US', '18657' , 'Software-US', '18659' , 'Software-US', '18660' ,
  'Software-US', '18800' , 'Software-EMEA', '18999' , 'Software-US', '19103' , 'Software-US', '19198' , 'Software-US', '19270' , 'Software-US', '19348' , 'Software-EMEA', '19354' , 'Software-US', '19426' , 'Software-US', '19474' , 'Software-US', '19514' , 'Software-US', '19515' , 'Software-US', '19598' , 'Software-US', '19642' , 'Software-US', '19645' , 'Software-US', '19662' , 'Software-US', '19704' , 'Software-US', '19746' , 'Software-US', '19829' , 'Software-US', '19831' , 'Software-US', '19849' , 'Software-US', '19883' , 'Software-US', '19909' , 'Software-US', '19921' , 'Software-US', '19939' , 'Software-US', '20233' , 'Software-US', '20297' , 'Software-EMEA', '20306' , 'Software-US', '20382' , 'Software-US', '20463' , 'Software-US', '20480' , 'Software-US', '20484' , 'Software-US', '20508' , 'Software-US', '20518' , 'Software-US', '20543' , 'Software-US', '20558' , 'Software-US', '20683' , 'Software-EMEA', '20722' , 'Software-US', '21240' , 'Software-US', '21241' , 'Gaming-US',
  '21242' , 'Software-US', '21243' , 'Software-US', '21247' , 'Software-US', '21257' , 'Software-US', '21326' , 'Software-US', '21430' , 'Software-US', '21457' , 'Software-US', '21470' , 'Software-US', '21601' , 'Software-US', '21627' , 'Software-EMEA', '21734' , 'Software-US', '21736' , 'Software-US', '21763' , 'Software-US', '21803' , 'Software-US', '21810' , 'Software-US', '21872' , 'Software-US', '22288' , 'Software-US', '22330' , 'Software-US', '22336' , 'Software-US', '22396' , 'Software-EMEA', '22402' , 'Software-EMEA', '22411' , 'Software-US', '22589' , 'Software-US', '22608' , 'Software-US', '22609' , 'Software-US', '22678' , 'Software-US', '22681' , 'Software-US', '22706' , 'Software-EMEA', '22716' , 'Software-EMEA', '22741' , 'Software-EMEA', '22766' , 'Software-US', '23051' , 'Software-US', '23725' , 'Software-EMEA', '24169' , 'Software-EMEA', '24366' , 'Software-US', '25026' , 'Software-US', '25169' , 'Software-EMEA', '25269' , 'Software-US', '25390' , 'Software-US',
  '25472' , 'Software-US', '25551' , 'Software-US', '25554' , 'Software-US', '25555' , 'Software-US', '25594' , 'Software-EMEA', '25712' , 'Software-US', '25752' , 'Software-US', '25892' , 'Software-US', '25953' , 'Software-US', '26271' , 'Software-US', '26272' , 'Software-US', '26451' , 'Software-EMEA', '26539' , 'Software-EMEA', '26571' , 'Software-US', '26572' , 'Software-US', '26651' , 'Software-US', '26774' , 'Software-US', '26775' , 'Software-US', '26812' , 'Software-US', '27038' , 'Software-US', '27171' , 'Software-US', '27314' , 'Software-US', '27403' , 'Software-EMEA', '27452' , 'Software-US', '27477' , 'Software-US', '27615' , 'Software-EMEA', '27617' , 'Software-US', '27741' , 'Software-EMEA', '27759' , 'Gaming-US', '27858' , 'Software-US', '27879' , 'Software-US', '27961' , 'Software-US', '28102' , 'Software-US', '28122' , 'Software-US', '28128' , 'Software-EMEA', '28263' , 'Software-EMEA', '28282' , 'Software-US', '28361' , 'Software-US', '28423' , 'Software-US', '28832'
  , 'Software-EMEA', '29438' , 'Software-EMEA', '29519' , 'Software-EMEA', '29566' , 'Software-EMEA', '30001' , 'Software-US', '30020' , 'Gaming-US', '30026' , 'Software-US', '30034' , 'Software-US', '30036' , 'Software-US', '30039' , 'Software-US', '30050' , 'Software-US', '30056' , 'Software-US', '30066' , 'Software-US', '30072' , 'Software-US', '30081' , 'Software-US', '30082' , 'Software-US', '30085' , 'Software-US', '30087' , 'Software-US', '30105' , 'Software-US', '30109' , 'Software-US', '30111' , 'Software-US', '30113' , 'Software-US', '30127' , 'Software-US', '30128' , 'Software-US', '30143' , 'Software-US', '30156' , 'Software-US', '30172' , 'Software-US', '30182' , 'Software-US', '30183' , 'Software-US', '30185' , 'Software-US', '30186' , 'Software-US', '30194' , 'Software-US', '30540' , 'Software-EMEA', '30845' , 'Software-EMEA', '31004' , 'Software-US', '31064' , 'Software-US', '31066' , 'Software-US', '31154' , 'Software-EMEA', '31220' , 'Software-US', '31308' ,
  'Software-EMEA', '31368' , 'Software-US', '31386' , 'Software-EMEA', '31524' , 'Gaming-US', '31621' , 'Software-US', '31763' , 'Software-US', '32388' , 'Software-US', '32470' , 'Software-US', '32471' , 'Software-US', '32636' , 'Software-EMEA', '32655' , 'Software-US', '32764' , 'Software-EMEA', '32776' , 'Software-EMEA', '32777' , 'Software-EMEA', '32795' , 'Software-US', '33195' , 'Software-US', '33221' , 'Software-EMEA', '33315' , 'Software-US', '33335' , 'Software-US', '33390' , 'Software-EMEA', '33536' , 'Software-US', '33995' , 'Software-US', '34038' , 'Software-EMEA', '34127' , 'Software-EMEA', '34336' , 'Software-US', '34449' , 'Software-EMEA', '34516' , 'Software-US', '34517' , 'Software-US', '34536' , 'Software-US', '34596' , 'Software-US', '34975' , 'Software-US', '35035' , 'Software-US', '35436' , 'Software-US', '35475' , 'Software-US', '35580' , 'Software-US', '35715' , 'Software-US', '35804' , 'Software-US', '35975' , 'Software-US', '36296' , 'Software-US', '36315' ,
  'Software-US', '36536' , 'Software-EMEA', '36555' , 'Software-US', '36575' , 'Software-US', '36655' , 'Software-US', '36675' , 'Software-US', '36755' , 'Software-US', '36815' , 'Software-US', '36915' , 'Software-US', '36935' , 'Software-US', '37196' , 'Software-US', '37378' , 'Software-US', '37396' , 'Software-US', '37591' , 'Software-US', '37894' , 'Software-US', '37912' , 'Software-US', '38111' , 'Software-US', '38133' , 'Software-US', '38152' , 'Software-EMEA', '38412' , 'Software-US', '38712' , 'Software-US', '38732' , 'Software-US', '38772' , 'Software-US', '38792' , 'Software-US', '38893' , 'Software-US', '39152' , 'Software-US', '39312' , 'Software-US', '39352' , 'Software-US', '39372' , 'Software-US', '39492' , 'Software-US', '39634' , 'Software-US', '39692' , 'Software-US', '39693' , 'Software-EMEA', '39694' , 'Software-EMEA', '39695' , 'Software-EMEA', '39696' , 'Software-US', '39738' , 'Software-EMEA', '39892' , 'Software-US', '39933' , 'Software-US', '39935' ,
  'Software-US', '40017' , 'Software-US', '40052' , 'Software-US', '40108' , 'Software-EMEA', '40113' , 'Software-US', '40192' , 'Software-US', '40278' , 'Software-US', '40321' , 'Software-US', '40361' , 'Software-EMEA', '40362' , 'Software-EMEA', '40525' , 'Software-US', '40565' , 'Gaming-US', '40609' , 'Software-US', '40612' , 'Software-US', '40766' , 'Software-US', '41034' , 'Software-EMEA', '41045' , 'Gaming-US', '41065' , 'Software-US', '41105' , 'Software-US', '41106' , 'Software-US', '41107' , 'Software-US', '41365' , 'Software-US', '41505' , 'Software-EMEA', '41606' , 'Software-EMEA', '41647' , 'Software-EMEA', '41648' , 'Software-EMEA', '41650' , 'Software-EMEA', '41652' , 'Software-EMEA', '41653' , 'Software-EMEA', '41683' , 'Software-EMEA', '41885' , 'Software-US', '41965' , 'Software-US', '42005' , 'Software-US', '42006' , 'Software-US', '42265' , 'Software-US', '42506' , 'Software-US', '42585' , 'Software-US', '43025' , 'Software-US', '43405' , 'Software-US', '43525' ,
  'Software-US', '43585' , 'Software-US', '43625' , 'Software-US', '44005' , 'Software-US', '44026' , 'Software-US', '44125' , 'Software-US', '44148' , 'Software-US', '44165' , 'Software-US', '44245' , 'Software-US', '44265' , 'Software-US', '44305' , 'Software-US', '44328' , 'Software-EMEA', '44345' , 'Software-EMEA', '44585' , 'Software-US', '44628' , 'Software-US', '44705' , 'Software-US', '44765' , 'Software-US', '44885' , 'Software-US', '44905' , 'Software-US', '45407' , 'Software-US', '45465' , 'Software-US', '45565' , 'Software-EMEA', '45566' , 'Software-EMEA', '45625' , 'Software-US', '45645' , 'Software-EMEA', '45766' , 'Software-EMEA', '45905' , 'Gaming-US', '45928' , 'Software-EMEA', '46006' , 'Software-EMEA', '46025' , 'Software-US', '46185' , 'Software-US', '46385' , 'Software-EMEA', '46485' , 'Software-EMEA', '47635' , 'Software-US', '47751' , 'Software-US', '47905' , 'Software-US', '47945' , 'Software-US', '48005' , 'Software-US', '48065' , 'Software-EMEA', '48205' ,
  'CE-US', '48445' , 'Software-US', '48566' , 'CE-US', '48605' , 'Software-US', '48625' , 'Software-US', '48665' , 'Software-US', '48706' , 'Software-US', '48745' , 'Software-US', '48785' , 'Software-US', '48865' , 'Software-US', '48965' , 'Software-US', '49085' , 'Software-US', '49205' , 'Software-US', '49305' , 'Software-US', '49365' , 'Software-US', '49545' , 'Software-US', '49585' , 'CE-EMEA', '49626' , 'Software-US', '49665' , 'Software-US', '49666' , 'Software-US', '49725' , 'Software-US', '49745' , 'Software-EMEA', '49805' , 'Software-US', '49826' , 'Software-EMEA', '50004' , 'Software-EMEA', '50013' , 'Software-EMEA', '50015' , 'Software-EMEA', '50016' , 'Software-EMEA', '50019' , 'Software-EMEA', '50024' , 'Software-EMEA', '50025' , 'Software-US', '50027' , 'Software-EMEA', '50029' , 'Software-US', '50030' , 'Software-EMEA', '50032' , 'Software-EMEA', '50033' , 'Software-EMEA', '50035' , 'Software-EMEA', '50036' , 'Software-EMEA', '50039' , 'Software-EMEA', '50040' ,
  'Software-EMEA', '50041' , 'Software-EMEA', '50042' , 'Software-EMEA', '50043' , 'Software-EMEA', '50045' , 'Software-EMEA', '50046' , 'Software-EMEA', '50047' , 'Software-EMEA', '50048' , 'Software-EMEA', '50050' , 'Software-EMEA', '50053' , 'Software-EMEA', '50055' , 'Software-EMEA', '50056' , 'Software-EMEA', '50057' , 'Software-EMEA', '50060' , 'Software-US', '50074' , 'Software-EMEA', '50075' , 'Software-EMEA', '50079' , 'Software-EMEA', '50080' , 'Software-EMEA', '50089' , 'Software-US', '50091' , 'Software-EMEA', '50092' , 'Software-EMEA', '50101' , 'Software-EMEA', '50103' , 'Software-US', '50105' , 'Software-EMEA', '50107' , 'Software-EMEA', '50108' , 'Software-EMEA', '50111' , 'Software-EMEA', '50113' , 'Software-EMEA', '50114' , 'Software-US', '50116' , 'Software-EMEA', '50117' , 'Software-EMEA', '50120' , 'Software-EMEA', '50121' , 'Software-EMEA', '50122' , 'Software-EMEA', '50123' , 'Software-EMEA', '50125' , 'Software-US', '50127' , 'Software-US', '50128' ,
  'Software-EMEA', '50129' , 'Software-EMEA', '50130' , 'Software-EMEA', '50132' , 'Software-EMEA', '50133' , 'Software-EMEA', '50134' , 'Software-US', '50135' , 'Software-EMEA', '50136' , 'Software-US', '50137' , 'Software-EMEA', '50140' , 'Software-US', '50141' , 'Software-EMEA', '50143' , 'Software-EMEA', '50144' , 'Software-EMEA', '50145' , 'Software-EMEA', '50147' , 'Software-EMEA', '50150' , 'Software-EMEA', '50151' , 'Software-EMEA', '50152' , 'Software-EMEA', '50153' , 'Software-EMEA', '50154' , 'Software-EMEA', '50156' , 'Software-EMEA', '50157' , 'Software-EMEA', '50158' , 'Software-EMEA', '50159' , 'Software-EMEA', '50160' , 'Software-EMEA', '50161' , 'Software-EMEA', '50164' , 'Software-EMEA', '50166' , 'Software-EMEA', '50167' , 'Software-EMEA', '50169' , 'Software-EMEA', '50170' , 'Software-EMEA', '50173' , 'Software-US', '50175' , 'Software-EMEA', '50179' , 'Software-EMEA', '50180' , 'Software-EMEA', '50181' , 'Software-EMEA', '50182' , 'Software-EMEA', '50183' ,
  'Software-EMEA', '50185' , 'Software-US', '50188' , 'Software-EMEA', '50189' , 'Software-EMEA', '50190' , 'Software-EMEA', '50191' , 'Software-EMEA', '50192' , 'Software-US', '50193' , 'Software-EMEA', '50194' , 'Software-EMEA', '50195' , 'Software-EMEA', '50196' , 'Software-EMEA', '50197' , 'Software-US', '50198' , 'Software-EMEA', '50199' , 'Software-US', '50202' , 'Software-EMEA', '50203' , 'Software-EMEA', '50204' , 'Software-EMEA', '50206' , 'Software-US', '50207' , 'Software-EMEA', '50210' , 'Software-EMEA', '50211' , 'Software-EMEA', '50212' , 'Software-EMEA', '50215' , 'Software-EMEA', '50217' , 'Software-EMEA', '50220' , 'Software-US', '50224' , 'Software-EMEA', '50225' , 'Software-EMEA', '50227' , 'Software-EMEA', '50233' , 'Software-EMEA', '50234' , 'Software-EMEA', '50235' , 'Software-EMEA', '50237' , 'Software-EMEA', '50238' , 'Software-EMEA', '50240' , 'Software-EMEA', '50244' , 'Software-EMEA', '50251' , 'Software-EMEA', '50254' , 'Software-US', '50256' ,
  'Software-EMEA', '50260' , 'Software-EMEA', '50262' , 'Software-US', '50264' , 'Software-EMEA', '50266' , 'Software-US', '50268' , 'Software-EMEA', '50269' , 'Software-EMEA', '50270' , 'Software-EMEA', '50271' , 'Software-EMEA', '50272' , 'Software-EMEA', '50273' , 'Software-EMEA', '50274' , 'Software-EMEA', '50275' , 'Software-EMEA', '50277' , 'Software-EMEA', '50280' , 'Software-EMEA', '50281' , 'Software-EMEA', '50282' , 'Software-EMEA', '50284' , 'Software-US', '50286' , 'Software-EMEA', '50287' , 'Software-EMEA', '50288' , 'Software-EMEA', '50289' , 'Software-EMEA', '50293' , 'Software-EMEA', '50294' , 'Software-EMEA', '50295' , 'Software-EMEA', '50297' , 'Software-EMEA', '50300' , 'Software-EMEA', '50301' , 'Software-US', '50303' , 'Software-EMEA', '50304' , 'Software-EMEA', '50308' , 'Software-EMEA', '50309' , 'Software-EMEA', '50310' , 'Software-EMEA', '50312' , 'Software-EMEA', '50314' , 'Software-US', '50315' , 'Software-EMEA', '50316' , 'Software-EMEA', '50317' ,
  'Software-EMEA', '50318' , 'Software-US', '50319' , 'Software-US', '50320' , 'Software-US', '50322' , 'Software-US', '50325' , 'Software-US', '50327' , 'Software-EMEA', '50328' , 'Software-EMEA', '50329' , 'Software-EMEA', '50334' , 'Software-US', '50336' , 'Software-EMEA', '50340' , 'Software-EMEA', '50347' , 'Software-US', '50353' , 'Software-EMEA', '50357' , 'Software-EMEA', '50363' , 'Software-EMEA', '50364' , 'Software-EMEA', '50367' , 'Software-US', '50368' , 'Software-EMEA', '50370' , 'Software-EMEA', '50384' , 'Software-US', '50389' , 'Software-EMEA', '50393' , 'Software-EMEA', '50395' , 'Software-EMEA', '50396' , 'Software-EMEA', '50398' , 'Software-EMEA', '50399' , 'Software-EMEA', '50401' , 'Software-EMEA', '50402' , 'Software-EMEA', '50403' , 'Software-EMEA', '50404' , 'Software-EMEA', '50405' , 'Software-EMEA', '50406' , 'Software-EMEA', '50407' , 'Software-EMEA', '50411' , 'Software-US', '50413' , 'Software-EMEA', '50417' , 'Software-EMEA', '50418' , 'Software-EMEA',
  '50419' , 'Software-EMEA', '50420' , 'Software-EMEA', '50421' , 'Software-EMEA', '50422' , 'Software-EMEA', '50423' , 'Software-EMEA', '50424' , 'Software-EMEA', '50425' , 'Software-EMEA', '50427' , 'Software-EMEA', '50428' , 'Software-EMEA', '50429' , 'Software-EMEA', '50430' , 'Software-US', '50431' , 'Software-EMEA', '50433' , 'Software-EMEA', '50434' , 'Software-US', '50437' , 'Software-EMEA', '50438' , 'Software-EMEA', '50439' , 'Software-EMEA', '50440' , 'Software-EMEA', '50442' , 'Software-EMEA', '50443' , 'Software-EMEA', '50444' , 'Software-US', '50447' , 'Software-EMEA', '50448' , 'Software-US', '50452' , 'Software-US', '50453' , 'Software-EMEA', '50454' , 'Software-EMEA', '50455' , 'Software-EMEA', '50457' , 'Software-EMEA', '50458' , 'Software-EMEA', '50463' , 'Software-EMEA', '50465' , 'Software-US', '50466' , 'Software-EMEA', '50467' , 'Software-US', '50469' , 'Software-US', '50471' , 'Software-US', '50473' , 'Software-EMEA', '50475' , 'Software-EMEA', '50476' ,
  'Software-EMEA', '50479' , 'Software-EMEA', '50483' , 'Software-US', '50493' , 'Software-EMEA', '50494' , 'Software-EMEA', '50495' , 'Software-EMEA', '50496' , 'Software-EMEA', '50504' , 'Software-EMEA', '50505' , 'Gaming-US', '50506' , 'Software-EMEA', '50508' , 'Software-EMEA', '50510' , 'Software-US', '50519' , 'Software-EMEA', '50520' , 'Software-EMEA', '50522' , 'Software-EMEA', '50523' , 'Software-EMEA', '50524' , 'Software-EMEA', '50529' , 'Software-US', '50531' , 'Software-EMEA', '50533' , 'Software-US', '50538' , 'Software-EMEA', '50540' , 'Software-US', '50542' , 'Software-US', '50543' , 'Software-EMEA', '50544' , 'Software-EMEA', '50545' , 'Software-US', '50546' , 'Software-US', '50550' , 'Software-EMEA', '50552' , 'Software-EMEA', '50556' , 'Software-EMEA', '50557' , 'Software-EMEA', '50559' , 'Software-EMEA', '50560' , 'Software-US', '50563' , 'Software-EMEA', '50567' , 'Software-EMEA', '50569' , 'Software-EMEA', '50572' , 'Software-EMEA', '50574' , 'Software-EMEA',
  '50575' , 'Software-US', '50577' , 'Software-EMEA', '50579' , 'Software-EMEA', '50580' , 'Software-EMEA', '50588' , 'Software-EMEA', '50589' , 'Software-US', '50590' , 'Software-EMEA', '50591' , 'Software-EMEA', '50592' , 'Software-EMEA', '50593' , 'Software-EMEA', '50594' , 'Software-EMEA', '50595' , 'Software-EMEA', '50599' , 'Software-EMEA', '50600' , 'Software-EMEA', '50601' , 'Software-EMEA', '50603' , 'Software-US', '50604' , 'Software-EMEA', '50606' , 'Software-EMEA', '50612' , 'Software-EMEA', '50615' , 'Software-EMEA', '50619' , 'Software-EMEA', '50622' , 'Software-EMEA', '50623' , 'Software-EMEA', '50625' , 'Software-US', '50629' , 'Software-EMEA', '50632' , 'Software-US', '50633' , 'Software-US', '50635' , 'Software-EMEA', '50641' , 'Software-EMEA', '50642' , 'Software-US', '50645' , 'Software-US', '50647' , 'Software-EMEA', '50651' , 'Software-US', '50653' , 'Software-EMEA', '50657' , 'Software-US', '50658' , 'Software-EMEA', '50663' , 'Software-EMEA', '50664' ,
  'Software-EMEA', '50665' , 'Software-EMEA', '50666' , 'Software-US', '50673' , 'Software-EMEA', '50674' , 'Software-EMEA', '50676' , 'Software-US', '50677' , 'Software-US', '50680' , 'Software-EMEA', '50685' , 'Software-EMEA', '50686' , 'Software-EMEA', '50690' , 'Software-US', '50691' , 'Software-US', '50693' , 'Software-EMEA', '50699' , 'Software-EMEA', '50703' , 'Software-EMEA', '50705' , 'Software-EMEA', '50706' , 'Software-US', '50707' , 'Software-EMEA', '50708' , 'Software-EMEA', '50709' , 'Software-EMEA', '50710' , 'Software-EMEA', '50711' , 'Software-EMEA', '50713' , 'Software-EMEA', '50714' , 'Software-EMEA', '50716' , 'Software-EMEA', '50717' , 'Software-EMEA', '50718' , 'Software-EMEA', '50721' , 'Software-EMEA', '50724' , 'Software-EMEA', '50725' , 'Software-EMEA', '50726' , 'Software-EMEA', '50727' , 'Symantec', '50728' , 'Software-US', '50729' , 'Software-US', '50731' , 'Software-EMEA', '50733' , 'Software-EMEA', '50735' , 'Software-EMEA', '50736' , 'Software-EMEA',
  '50738' , 'Software-US', '50739' , 'Software-US', '50740' , 'Software-EMEA', '50741' , 'Software-EMEA', '50744' , 'Software-EMEA', '50745' , 'Software-US', '50746' , 'Software-EMEA', '50747' , 'Software-EMEA', '50756' , 'Software-EMEA', '50757' , 'Software-EMEA', '50761' , 'Software-EMEA', '50763' , 'Software-US', '50765' , 'Software-US', '50766' , 'Software-EMEA', '50767' , 'Software-EMEA', '50769' , 'Software-US', '50770' , 'Software-EMEA', '50771' , 'Software-EMEA', '50772' , 'Software-EMEA', '50773' , 'Software-EMEA', '50780' , 'Software-EMEA', '50781' , 'Software-US', '50784' , 'Software-EMEA', '50790' , 'Software-EMEA', '50794' , 'Software-EMEA', '50795' , 'Software-US', '50800' , 'Software-US', '50801' , 'Software-US', '50807' , 'Software-EMEA', '50808' , 'Software-EMEA', '50813' , 'Software-EMEA', '50814' , 'Software-EMEA', '50815' , 'Software-EMEA', '50821' , 'Software-EMEA', '50822' , 'Software-US', '50823' , 'Software-EMEA', '50826' , 'Software-US', '50833' ,
  'Software-EMEA', '50835' , 'Software-EMEA', '50836' , 'Software-EMEA', '50837' , 'Software-EMEA', '50838' , 'Software-US', '50839' , 'Software-US', '50840' , 'Software-US', '50842' , 'Software-EMEA', '50845' , 'Software-US', '50848' , 'Software-EMEA', '50849' , 'Software-EMEA', '50854' , 'Software-EMEA', '50855' , 'Software-EMEA', '50860' , 'Software-EMEA', '50861' , 'Software-EMEA', '50862' , 'Software-EMEA', '50865' , 'Software-US', '50866' , 'Software-EMEA', '50867' , 'Software-EMEA', '50868' , 'Software-US', '50870' , 'Software-EMEA', '50871' , 'Software-EMEA', '50874' , 'Software-US', '50875' , 'Software-EMEA', '50882' , 'Software-EMEA', '50884' , 'Software-EMEA', '50885' , 'Software-EMEA', '50886' , 'Software-US', '50887' , 'Software-US', '50890' , 'Software-EMEA', '50892' , 'Software-EMEA', '50895' , 'Software-EMEA', '50899' , 'Software-EMEA', '50902' , 'Software-EMEA', '50904' , 'Software-EMEA', '50905' , 'Symantec', '50910' , 'Software-EMEA', '50911' , 'Software-EMEA',
  '50925' , 'Software-US', '50937' , 'Software-EMEA', '50938' , 'Software-EMEA', '50939' , 'Software-EMEA', '50941' , 'Software-EMEA', '50943' , 'Software-EMEA', '50944' , 'Software-EMEA', '50945' , 'Software-EMEA', '50946' , 'Software-EMEA', '50948' , 'Software-EMEA', '50951' , 'Software-EMEA', '50952' , 'Software-EMEA', '50954' , 'Software-EMEA', '50955' , 'Software-US', '50956' , 'Software-EMEA', '50957' , 'Software-EMEA', '50958' , 'Software-EMEA', '50959' , 'Software-EMEA', '50961' , 'Software-EMEA', '50964' , 'Software-EMEA', '50965' , 'Software-US', '50967' , 'Software-EMEA', '50968' , 'Software-EMEA', '50972' , 'Software-EMEA', '50973' , 'Software-EMEA', '50974' , 'Software-US', '50978' , 'Software-EMEA', '50979' , 'Software-EMEA', '50980' , 'Software-EMEA', '50984' , 'Software-EMEA', '50986' , 'Software-US', '50987' , 'Software-EMEA', '50993' , 'Software-US', '50997' , 'Software-EMEA', '51003' , 'Software-US', '51004' , 'Software-US', '51007' , 'Software-EMEA', '51106' ,
  'Software-US', '51107' , 'Software-US', '51125' , 'Software-EMEA', '51126' , 'Software-US', '51215' , 'Software-US', '51438' , 'Software-US', '51498' , 'Software-US', '51599' , 'Software-US', '51646' , 'Software-US', '51647' , 'Software-US', '51656' , 'Software-US', '51673' , 'Software-EMEA', '51679' , 'Software-US', '51682' , 'Software-US', '51765' , 'Software-US', '51817' , 'Software-US', '51877' , 'Software-US', '52017' , 'Software-US', '52098' , 'Software-EMEA', '52117' , 'Software-US', '52157' , 'Software-US', '52237' , 'Software-US', '52277' , 'Software-US', '52437' , 'Software-US', '52477' , 'Software-US', '52497' , 'Software-US', '52517' , 'Software-US', '52557' , 'Software-US', '52663' , 'Software-US', '52757' , 'CE-EMEA', '52778' , 'Software-US', '52838' , 'Software-US', '52997' , 'Software-US', '52998' , 'Software-US', '52999' , 'Software-US', '53059' , 'CE-EMEA', '53864' , 'Software-US', '54367' , 'Software-US', '54379' , 'Software-US', '54392' , 'Software-US', '54399'
  , 'Software-US', '54439' , 'Software-US', '54479' , 'Software-US', '54480' , 'Software-US', '54498' , 'Software-US', '54738' , 'Software-US', '54740' , 'Software-US', '54858' , 'Software-US', '55766' , 'Software-US', '55939' , 'Software-US', '56138' , 'Software-US', '56258' , 'Software-US', '56298' , 'Software-US', '56378' , 'Software-US', '56439' , 'Software-US', '56498' , 'Software-US', '56578' , 'Software-US', '56678' , 'Software-US', '56718' , 'Gaming-US', '56858' , 'Gaming-US', '57238' , 'Software-US', '57358' , 'Software-US', '57599' , 'Software-US', '57878' , 'Software-US', '57958' , 'Software-US', '58058' , 'Software-US', '58098' , 'Software-US', '58178' , 'Software-US', '58198' , 'Software-US', '58278' , 'Software-US', '58481' , 'Software-US', '59689' , 'Software-US', '59745' , 'Software-US', '59764' , 'Software-US', '59801' , 'Software-US', '60044' , 'Software-US', '60427' , 'Software-US', '60429' , 'Software-US', '60467' , 'Software-US', '60536' , 'Software-US', '61219'
  , 'Software-US', '61439' , 'Software-US', '61840' , 'Software-US', '62100' , 'Software-US', '62180' , 'Gaming-US', '62259' , 'Software-US', '63299' , 'Software-US', '63438' , 'Gaming-US', '64118' , 'Software-US', '64119' , 'Software-US', '64179' , 'Software-US', '64233' , 'Software-EMEA', '64459' , 'Software-US', '65360' , 'Software-US', '65361' , 'Software-US', '65362' , 'Software-US', '65559' , 'Software-US', '65619' , 'Software-US', '66019' , 'CE-EMEA', '67199' , 'Software-US', '67779' , 'Software-US', '67959' , 'Gaming-US', '68300' , 'Gaming-US', '68519' , 'Software-US', '68520' , 'Software-US', '68579' , 'Software-US', '68739' , 'Software-US', '68919' , 'Software-US', '69099' , 'Gaming-US', '69139' , 'Software-US', '69240' , 'Software-US', '69379' , 'Software-US', '69440' , 'Software-US', '70239' , 'Software-US', '70319' , 'Software-US', '70343' , 'Software-US', '70408' , 'Software-US', '70708' , 'Software-US', '70912' , 'Gaming-US', '71394' , 'Software-EMEA', '72508' ,
  'Gaming-US', '72509' , 'Gaming-US', '74408' , 'Software-US', '74708' , 'Gaming-US', '75208' , 'Gaming-US', '76508' , 'Software-US', '76908' , 'Software-US', '78008' , 'Software-US', '78453' , 'Software-EMEA', '78508' , 'Software-US', '80005' , 'Software-EMEA', '80027' , 'Software-EMEA', '80036' , 'Software-EMEA', '80037' , 'Software-EMEA', '80039' , 'Software-EMEA', '82308' , 'Software-US', '82708' , 'Software-EMEA', '82709' , 'Software-EMEA', '82710' , 'Software-EMEA', '83408' , 'Software-US', '84608' , 'Gaming-US', '84708' , 'Software-EMEA', '85308' , 'Software-EMEA', '85310' , 'Software-EMEA', '89508' , 'Software-US', '90000' , 'Software-EMEA', '90003' , 'Software-EMEA', '90309' , 'Software-US', '92309' , 'Software-US', '93709' , 'Software-US', '94509' , 'Software-US', '94709' , 'Gaming-US', '96309' , 'Software-US', '96310' , 'Software-US', '97210' , 'Software-US', '2002152' , 'Software-US', '2002153' , 'Software-US', '2002158' , 'Gaming-US', '13650003' , 'Software-US',
  '13650004' , 'Software-US', '13650005' , 'Software-US', '13650015' , 'Software-US', '13650038' , 'Software-US', '13650041' , 'CE-US', '13650055' , 'Software-US', '13650070' , 'Gaming-US', '13650071' , 'Software-US', '13650082' , 'CE-US', '13650105' , 'Software-US', '13650106' , 'Software-US', '13650110' , 'Software-US', '13650116' , 'Software-US', '13650120' , 'Software-US', '13650130' , 'Software-US', '13650133' , 'Gaming-US', '13650135' , 'Software-US', '13650147' , 'Software-US', '13650148' , 'Software-US', '13650149' , 'Software-US', '13650153' , 'Software-US', '13650161' , 'Software-US', '13650178' , 'Software-US', '13650220' , 'Software-US', '13650224' , 'Software-US', '13650226' , 'Software-US', '13650228' , 'Software-US', '13650233' , 'Gaming-US', '13650246' , 'Software-US', '13650247' , 'Software-US', '13650252' , 'Software-US', '13650278' , 'Software-US', '13650285' , 'Gaming-US', '13650294' , 'Software-US', '13650295' , 'Software-US', '13650300' , 'Software-US',
  '13650318' , 'Software-US', '13650320' , 'Software-US', '13650322' , 'Software-US', '13650324' , 'Software-US', '13650329' , 'Software-US', '13650339' , 'Software-US', '13650340' , 'Software-US', '13650348' , 'Software-EMEA', '13650368' , 'Software-US', '13650374' , 'Software-US', '13650379' , 'Software-US', '13650385' , 'Gaming-US', '13650396' , 'Software-US', '13650403' , 'Gaming-US', '13650404' , 'Gaming-US', '13650419' , 'Software-US', '13650420' , 'Software-US', '13650422' , 'Gaming-US', '13650433' , 'Software-US', '13650460' , 'Software-US', '13650462' , 'Software-US', '13650465' , 'Software-US', '13650469' , 'Gaming-US', '13650479' , 'Software-US', '13650490' , 'Software-US', '13650493' , 'Software-US', '13650494' , 'Software-US', '13650505' , 'Software-US', '13650510' , 'Software-US', '13650511' , 'Software-US', '13650514' , 'Software-EMEA', '13650529' , 'Software-US', '13650530' , 'Gaming-US', '13650533' , 'Software-US', '13650540' , 'Software-US', '13650541' ,
  'Software-US', '13650547' , 'CE-US', '13650554' , 'Software-US', '13650556' , 'Software-US', '13650559' , 'Software-US', '13650564' , 'Software-US', '13650569' , 'Software-US', '13650579' , 'Software-US', '13650584' , 'Software-US', '13650589' , 'Software-US', '13650602' , 'Software-US', '13650613' , 'Software-US', '13650621' , 'Software-US', '13650622' , 'Software-US', '13650631' , 'Software-US', '13650635' , 'Software-US', '13650641' , 'Software-US', '13650679' , 'Software-US', '13650738' , 'Gaming-US', '13650739' , 'Software-EMEA', '13650756' , 'Software-US', '13650766' , 'Software-EMEA', '13650770' , 'CE-US', '13650772' , 'Software-US', '13650782' , 'Software-US', '13650785' , 'Software-US', '13650786' , 'Gaming-US', '13650812' , 'Software-US', '13650828' , 'CE-US', '13650829' , 'CE-US', '13650830' , 'CE-US', '13650831' , 'CE-US', '13650832' , 'CE-US', '13650833' , 'CE-US', '13650837' , 'CE-US', '13650839' , 'CE-US', '13650843' , 'CE-US', '13650844' , 'CE-US', '13650857' ,
  'CE-US', '13650859' , 'Software-EMEA', '13650861' , 'Software-US', '13650876' , 'Software-US', '13650880' , 'Software-US', '13650924' , 'Software-US', '13650926' , 'Software-US', '13650932' , 'Software-EMEA', '13650936' , 'Software-US', '13650987' , 'CE-US', '13651039' , 'Software-US', '13651040' , 'Software-US', '13651051' , 'CE-EMEA', '13651053' , 'CE-US', '13651054' , 'Software-US', '13651055' , 'CE-US', '13651058' , 'CE-US', '13651060' , 'Software-US', '13651075' , 'Gaming-US', '13651077' , 'CE-US', '13651582' , 'CE-US', '13651588' , 'Gaming-US', '13651589' , 'Software-US', '13651590' , 'Gaming-US', '13651676' , 'CE-US', '13651773' , 'Software-US', '13651971' , 'Software-US', '13651984' , 'Software-US', '13652010' , 'Software-US', '13652030' , 'Software-US', '13652057' , 'Software-US', '13652059' , 'Software-US', '13653111' , 'Software-US', '13653148' , 'Software-US', '13653151' , 'Software-US', '13653463' , 'CE-US', '13653547' , 'CE-EMEA', '13654271' , 'CE-US', '13654335' ,
  'Software-EMEA', '13654350' , 'CE-US', '13654351' , 'CE-US', '13654352' , 'CE-US', '13654353' , 'CE-US', '13654675' , 'Software-US', '13654716' , 'CE-EMEA', '13654826' , 'CE-EMEA', '13654952' , 'CE-EMEA', '13654953' , 'CE-EMEA', '13655231' , 'Software-US', '21450018' , 'CE-EMEA', '200000000' , 'Software-EMEA', '200000363' , 'Software-EMEA', '200000497' , 'Software-EMEA', '200000501' , 'Software-EMEA', '200000552' , 'Software-EMEA', '200000804' , 'Software-US', '200002441' , 'Software-EMEA', '200002482' , 'Software-EMEA', '200002674' , 'Software-EMEA', '200003141' , 'Software-EMEA', '200003143' , 'Software-EMEA', '200003430' , 'Software-EMEA', '200003518' , 'Software-EMEA', '200003723' , 'Software-EMEA', '200003785' , 'Software-US', '200003906' , 'Software-EMEA', '200003908' , 'Software-EMEA', '200004221' , 'Software-US', '200004293' , 'Software-EMEA', '200004413' , 'Software-US', '200004494' , 'Software-EMEA', '200004774' , 'Software-EMEA', '200004779' , 'Software-EMEA',
  '200004792' , 'Software-EMEA', '200005050' , 'Software-EMEA', '200005097' , 'Software-EMEA', '200005160' , 'Software-EMEA', '200005175' , 'Software-EMEA', '200005190' , 'Software-EMEA', '200005934' , 'Software-EMEA', '200006022' , 'Software-EMEA', '200006295' , 'Software-EMEA', '200006390' , 'Software-EMEA', '200006456' , 'Software-EMEA', '200006494' , 'Software-EMEA', '200006929' , 'Software-EMEA', '200007127' , 'Software-US', '200007133' , 'Software-EMEA', '200007286' , 'Software-EMEA', '200007374' , 'Software-EMEA', '200007445' , 'Software-EMEA', '200007841' , 'Software-EMEA', '200007853' , 'Software-US', '200007918' , 'Software-EMEA', '200007927' , 'Software-EMEA', '200008616' , 'Software-EMEA', '200008684' , 'Software-EMEA', '200008763' , 'Software-US', '200009031' , 'Software-EMEA', '200009049' , 'Software-EMEA', '200009303' , 'Software-EMEA', '200009313' , 'Software-EMEA', '200009391' , 'Software-EMEA', '200009501' , 'Software-US', '200009724' , 'Software-EMEA', '200009860'
  , 'Software-US', '200009930' , 'Software-EMEA', '200010186' , 'Software-EMEA', '200010187' , 'Software-EMEA', '200010188' , 'Software-EMEA', '200010204' , 'Software-EMEA', '200010603' , 'Software-US', '200010757' , 'Software-EMEA', '200010880' , 'Software-EMEA', '200010988' , 'Software-EMEA', '200011193' , 'Software-EMEA', '200011348' , 'Software-EMEA', '200011579' , 'Software-EMEA', '200012218' , 'Software-EMEA', '200012445' , 'Software-EMEA', '200012446' , 'Software-EMEA', '200012584' , 'Software-EMEA', '200012844' , 'Software-EMEA', '200012902' , 'Software-US', '200013181' , 'Software-EMEA', '200013185' , 'Software-EMEA', '200013227' , 'Software-EMEA', '200013725' , 'Software-EMEA', '200013727' , 'Software-EMEA', '200014270' , 'Software-EMEA', '200014496' , 'Software-EMEA', '200014639' , 'Software-EMEA', '200014801' , 'Software-EMEA', '200015324' , 'Software-EMEA', '200016505' , 'Software-EMEA', '200016623' , 'Software-EMEA', '200016791' , 'Software-EMEA', '200016795' ,
  'Software-EMEA', '200016800' , 'Software-EMEA', '200016808' , 'Software-EMEA', '200016810' , 'Software-EMEA', '200016846' , 'Software-EMEA', '200016933' , 'Software-EMEA', '200017000' , 'Software-EMEA', '200017175' , 'Software-EMEA', '200017927' , 'Software-EMEA', '200018033' , 'Software-EMEA', '200018040' , 'Software-EMEA', '200018324' , 'Software-EMEA', '200019002' , 'Software-EMEA', '200019161' , 'Software-EMEA', '200019165' , 'Software-EMEA', '200019616' , 'Software-EMEA', '200019817' , 'Software-EMEA', '200020242' , 'Software-EMEA', '200020732' , 'Software-US', '200021162' , 'Software-EMEA', '200021237' , 'Software-EMEA', '200021384' , 'Software-EMEA', '200021456' , 'Software-EMEA', '200021567' , 'Software-EMEA', '200021625' , 'Software-EMEA', '200021817' , 'Software-EMEA', '200022028' , 'Software-EMEA', '200022269' , 'Software-EMEA', '200023985' , 'Software-EMEA', '200024154' , 'Software-EMEA', '200024156' , 'Software-EMEA', '200024287' , 'Software-EMEA', '200024433' ,
  'Software-US', '200024476' , 'Software-EMEA', '200024742' , 'Software-US', '200025463' , 'Software-EMEA', '200025631' , 'Software-EMEA', '200026745' , 'Software-EMEA', '200026961' , 'Software-EMEA', '200027224' , 'Software-US', '200027584' , 'Software-EMEA', '200027585' , 'Software-EMEA', '200027591' , 'Software-EMEA', '200027670' , 'Software-EMEA', '200027674' , 'Software-EMEA', '200027856' , 'Software-EMEA', '200027883' , 'Software-EMEA', '200028108' , 'Software-EMEA', '200028790' , 'Software-EMEA', '200028791' , 'Software-EMEA', '200028898' , 'Software-EMEA', '200029087' , 'Software-EMEA', '200029240' , 'Software-EMEA', '200029257' , 'Software-EMEA', '200029303' , 'Software-EMEA', '200029332' , 'Software-EMEA', '200029510' , 'Software-EMEA', '200029721' , 'Software-EMEA', '200030000' , 'Software-EMEA', '200030001' , 'Software-EMEA', '200030216' , 'Software-EMEA', '200030551' , 'Software-EMEA', '200030767' , 'Software-EMEA', '200030768' , 'Software-EMEA', '200031018' ,
  'Software-EMEA', '200031068' , 'Software-EMEA', '200031122' , 'Software-EMEA', '200031180' , 'Software-EMEA', '200031246' , 'Software-EMEA', '200031250' , 'Software-EMEA', '200031255' , 'Software-EMEA', '200031812' , 'Software-EMEA', '200031861' , 'Software-EMEA', '200032008' , 'Software-EMEA', '200032349' , 'Software-EMEA', '200032400' , 'Software-EMEA', '200032402' , 'Software-EMEA', '200032550' , 'Software-EMEA', '200033165' , 'Software-EMEA', '200033196' , 'Software-EMEA', '200033216' , 'Software-EMEA', '200033390' , 'Software-EMEA', '200033566' , 'Software-EMEA', '200033581' , 'Software-EMEA', '200033582' , 'Software-US', '200033699' , 'Software-EMEA', '200033764' , 'Software-EMEA', '200033991' , 'Software-EMEA', '200034322' , 'Software-EMEA', '200034325' , 'Software-EMEA', '200034354' , 'Software-EMEA', '200034358' , 'Software-EMEA', '200034439' , 'Software-EMEA', '200034472' , 'Software-EMEA', '200034475' , 'Software-EMEA', '200034525' , 'Software-EMEA', '200034716' ,
  'Software-EMEA', '200034834' , 'Software-EMEA', '200035139' , 'Software-EMEA', '200035349' , 'Software-EMEA', '200035406' , 'Software-EMEA', '200035427' , 'Software-US', '200035569' , 'Software-EMEA', '200035573' , 'Software-EMEA', '200035612' , 'Software-EMEA', '200036197' , 'Software-EMEA', '200036203' , 'Software-EMEA', '200036204' , 'Software-EMEA', '200036331' , 'Software-EMEA', '200036645' , 'Software-US', '200037668' , 'Software-US', '200037734' , 'Software-EMEA', '200037862' , 'Software-EMEA', '200037863' , 'Software-EMEA', '200037867' , 'Software-EMEA', '200040444' , 'Software-EMEA', '200040461' , 'Software-EMEA', '200040619' , 'Software-EMEA', '200040652' , 'Software-EMEA', '200042023' , 'Software-EMEA', '200042027' , 'Software-EMEA', '200042083' , 'Software-EMEA', '200042944' , 'Software-EMEA', '200043619' , 'Software-EMEA', '200043726' , 'Software-EMEA', '200045342' , 'Software-EMEA', '200045386' , 'Software-EMEA', '200045535' , 'Software-US', '200046639' ,
  'Software-EMEA', '200046705' , 'Software-EMEA', '200046741' , 'Software-EMEA', '200046743' , 'Software-EMEA', '200047006' , 'Software-EMEA', '200047008' , 'Software-EMEA', '200047140' , 'Software-EMEA', '200047470' , 'Software-EMEA', '200047823' , 'Software-EMEA', '200047846' , 'Software-US', '200047849' , 'Software-EMEA', '200047852' , 'Software-EMEA', '200047855' , 'Software-EMEA', '200047861' , 'Software-EMEA', '200047863' , 'Software-EMEA', '200047961' , 'Software-EMEA', '200048240' , 'Software-EMEA', '200048342' , 'Software-EMEA', '200048351' , 'Software-US', '200048734' , 'Software-EMEA', '200049090' , 'Software-EMEA', '200049186' , 'Software-EMEA', '200049575' , 'Software-EMEA', '200049845' , 'Software-EMEA', '200050744' , 'Software-EMEA', '200051243' , 'Software-EMEA', '200051313' , 'Software-EMEA', '200051566' , 'Software-EMEA', '200051655' , 'Software-EMEA', '200051846' , 'Software-EMEA', '200051969' , 'Software-EMEA', '200052147' , 'Software-EMEA', '200053339' ,
  'Software-EMEA', '200053641' , 'Software-US', '200054194' , 'Software-EMEA', '200054759' , 'Software-US', '200054897' , 'Software-EMEA', '200055036' , 'Software-EMEA', '200055336' , 'Software-EMEA', '200055397' , 'Software-EMEA', '200055692' , 'Software-EMEA', '200055940' , 'Software-EMEA', '200056679' , 'Software-EMEA', '200056728' , 'Software-EMEA', '200056891' , 'Software-EMEA', '200057110' , 'Software-EMEA', '200057495' , 'Software-EMEA', '200057697' , 'Software-EMEA', '200057799' , 'Software-EMEA', '200057818' , 'Software-EMEA', '200058040' , 'Software-EMEA', '200058435' , 'Software-EMEA', '200058497' , 'Software-EMEA', '200058925' , 'Software-EMEA', '200058978' , 'Software-EMEA', '200058984' , 'Software-EMEA', '200059040' , 'Software-EMEA', '200059461' , 'Software-EMEA', '200059548' , 'Software-US', '200059871' , 'Software-EMEA', '200060144' , 'Software-EMEA', '200060257' , 'Software-EMEA', '200060323' , 'Software-EMEA', '200060468' , 'Software-EMEA', '200060588' ,
  'Software-EMEA', '200060979' , 'Software-EMEA', '200060992' , 'Software-EMEA', '200061022' , 'Software-EMEA', '200061156' , 'Software-EMEA', '200061364' , 'Software-EMEA', '200061378' , 'Software-EMEA', '200061645' , 'Software-EMEA', '200061777' , 'Software-EMEA', '200062077' , 'Software-EMEA', '200062371' , 'Software-EMEA', '200062613' , 'Software-EMEA', '200062623' , 'Software-EMEA', '200062755' , 'Software-EMEA', '200062760' , 'Software-EMEA', '200062895' , 'Software-EMEA', '200063286' , 'Software-EMEA', '200063370' , 'Software-EMEA', '200063385' , 'Software-EMEA', '200063649' , 'Software-EMEA', '200063703' , 'Software-EMEA', '200063708' , 'Software-EMEA', '200064296' , 'Software-EMEA', '200064470' , 'Software-EMEA', '200065161' , 'Software-EMEA', '200065610' , 'Software-EMEA', '200065650' , 'Software-EMEA', '200065658' , 'Software-EMEA', '200065660' , 'Software-EMEA', '200065717' , 'Software-EMEA', '200065719' , 'Software-EMEA', '200065822' , 'Software-EMEA', '200066523' ,
  'Software-EMEA', '200066672' , 'Software-EMEA', '200066839' , 'Software-EMEA', '200067054' , 'Software-EMEA', '200067464' , 'Software-EMEA', '200067465' , 'Software-EMEA', '200067468' , 'Software-EMEA', '200067471' , 'Software-EMEA', '200067733' , 'Software-EMEA', '200067744' , 'Software-EMEA', '200067771' , 'Software-EMEA', '200067967' , 'Software-EMEA', '200068113' , 'Software-EMEA', '200068257' , 'Software-EMEA', '200068283' , 'Software-EMEA', '200068442' , 'Software-EMEA', '200068567' , 'Software-EMEA', '200068629' , 'Software-EMEA', '200068631' , 'Software-EMEA', '200068702' , 'Software-EMEA', '200068838' , 'Software-EMEA', '200068839' , 'Software-EMEA', '200068901' , 'Software-EMEA', '200069097' , 'Software-EMEA', '200069099' , 'Software-EMEA', '200069123' , 'Software-US', '200069132' , 'Software-EMEA', '200069397' , 'Software-US', '200069399' , 'Software-EMEA', '200069656' , 'Software-EMEA', '200069666' , 'Software-EMEA', '200069730' , 'Software-US', '200069735' ,
  'Software-EMEA', '200070513' , 'Software-EMEA', '200070514' , 'Software-EMEA', '200070561' , 'Software-EMEA', '200070789' , 'Software-EMEA', '200070802' , 'Software-EMEA', '200071483' , 'Software-EMEA', '200071598' , 'Software-EMEA', '200071911' , 'Software-EMEA', '200071946' , 'Software-EMEA', '200072094' , 'Software-EMEA', '200072147' , 'Software-EMEA', '200072232' , 'Software-EMEA', '200072249' , 'Software-EMEA', '200072480' , 'Software-EMEA', '200072638' , 'Software-EMEA', '200072729' , 'Software-EMEA', '200072797' , 'Software-EMEA', '200073101' , 'Software-EMEA', '200073620' , 'Software-US', '200073650' , 'Software-US', '200073666' , 'Software-EMEA', '200073952' , 'Software-EMEA', '200074212' , 'Software-EMEA', '200074214' , 'Software-EMEA', '200074215' , 'Software-EMEA', '200074267' , 'Software-EMEA', '200074343' , 'Software-EMEA', '200074954' , 'Software-EMEA', '200074956' , 'Software-EMEA', '200074974' , 'Software-EMEA', '200075107' , 'Software-EMEA', '200075108' ,
  'Software-EMEA', '200075109' , 'Software-EMEA', '200075417' , 'Software-EMEA', '200075762' , 'Software-EMEA', '200075765' , 'Software-EMEA', '200076169' , 'Software-EMEA', '200076284' , 'Software-EMEA', '200076422' , 'Software-EMEA', '200076603' , 'Software-EMEA', '200077028' , 'Software-EMEA', '200077037' , 'Software-EMEA', '200077073' , 'Software-EMEA', '200077097' , 'Software-EMEA', '200077110' , 'Software-EMEA', '200077242' , 'Software-EMEA', '200077439' , 'Software-EMEA', '200077554' , 'Software-EMEA', '200077586' , 'Software-EMEA', '200077689' , 'Software-EMEA', '200077838' , 'Software-EMEA', '200077886' , 'Software-EMEA', '200078106' , 'Software-EMEA', '200078125' , 'Software-EMEA', '200078384' , 'Software-EMEA', '200078418' , 'Software-EMEA', '200078485' , 'Software-EMEA', '200078701' , 'Software-EMEA', '200078710' , 'Software-EMEA', '200078906' , 'Software-EMEA', '200079001' , 'Software-EMEA', '200079002' , 'Software-EMEA', '200079201' , 'Software-EMEA', '200079229' ,
  'Software-US', '200079240' , 'Software-EMEA', '200079242' , 'Software-EMEA', '200079290' , 'Software-EMEA', '200080147' , 'Software-EMEA', '200080245' , 'Software-EMEA', '200081141' , 'Software-US', '200081399' , 'Software-US', '200081557' , 'Software-EMEA', '200082539' , 'Software-EMEA', '200082692' , 'Software-EMEA', '200082698' , 'Software-EMEA', '200082734' , 'Software-EMEA', '200082977' , 'Software-EMEA', '200083549' , 'Software-EMEA', '200084785' , 'Software-EMEA', '200085292' , 'Software-EMEA', '200085295' , 'Software-EMEA', '200086261' , 'Software-EMEA', '200086276' , 'Software-EMEA', '200086277' , 'Software-EMEA', '200086278' , 'Software-EMEA', '200086279' , 'Software-EMEA', '200086284' , 'Software-EMEA', '200086309' , 'Software-EMEA', '200086375' , 'Software-EMEA', '200086485' , 'Software-EMEA', '200086491' , 'Software-EMEA', '200086516' , 'Software-EMEA', '200086549' , 'Software-EMEA', '200086552' , 'Software-EMEA', '200086555' , 'Software-EMEA', '200086593' ,
  'Software-EMEA', '200086605' , 'Software-EMEA', '200086768' , 'Software-EMEA', '200086819' , 'Software-EMEA', '200086821' , 'Software-US', '200087066' , 'Software-EMEA', '200087377' , 'Software-EMEA', '200087387' , 'Software-EMEA', '200087389' , 'Software-EMEA', '200087487' , 'Software-EMEA', '200087578' , 'Software-EMEA', '200087783' , 'Software-EMEA', '200087811' , 'Software-EMEA', '200088038' , 'Software-US', '200088227' , 'Software-EMEA', '200088240' , 'Software-EMEA', '200088304' , 'Software-EMEA', '200088507' , 'Software-EMEA', '200088714' , 'Software-EMEA', '200088717' , 'Software-EMEA', '200088719' , 'Software-EMEA', '200088721' , 'Software-EMEA', '200088723' , 'Software-EMEA', '200088724' , 'Software-EMEA', '200088727' , 'Software-EMEA', '200088731' , 'Software-EMEA', '200088732' , 'Software-EMEA', '200088733' , 'Software-EMEA', '200088735' , 'Software-EMEA', '200088772' , 'Software-EMEA', '200088781' , 'Software-EMEA', '200088984' , 'Software-EMEA', '200088986' ,
  'Software-EMEA', '200089014' , 'Software-EMEA', '200089020' , 'Software-EMEA', '200089068' , 'Software-EMEA', '200089155' , 'Software-EMEA', '200089539' , 'Software-US', '200089780' , 'Software-EMEA', '200090008' , 'Software-EMEA', '200090934' , 'Software-EMEA', '200091062' , 'Software-EMEA', '200091579' , 'Software-EMEA', '200091625' , 'Software-EMEA', '200091626' , 'Software-EMEA', '200091688' , 'Software-EMEA', '200091690' , 'Software-EMEA', '200092562' , 'Software-EMEA', '200092691' , 'Software-EMEA', '200093079' , 'Software-EMEA', '200093187' , 'Software-EMEA', '200093383' , 'Software-EMEA', '200093393' , 'Software-EMEA', '200093421' , 'Software-US', '200093785' , 'Software-EMEA', '200093789' , 'Software-EMEA', '200093804' , 'Software-EMEA', '200093885' , 'Software-US', '200095219' , 'Software-US', '200095262' , 'Software-US', '200095669' , 'Software-US', '200095708' , 'Software-US', '200095998' , 'Software-EMEA', '200096908' , 'Software-US', '200096979' , 'Software-EMEA',
  '200097260' , 'Software-EMEA', '200097727' , 'Software-EMEA', '200097830' , 'Software-EMEA', '200098118' , 'Software-EMEA', '200098120' , 'Software-US', '200098234' , 'Software-EMEA', '200098427' , 'Software-EMEA', '200098603' , 'Software-EMEA', '200098826' , 'Software-US', '200098896' , 'Software-EMEA', '200099546' , 'Software-EMEA', '200100843' , 'Software-EMEA', '200101767' , 'Software-EMEA', '200105568' , 'Software-EMEA', '200105759' , 'Software-EMEA', '200107638' , 'Software-EMEA', '200108671' , 'Software-EMEA', '200108739' , 'Software-US', '2001749ric' , 'CE-EMEA', '3mprint' , 'Software-US', '90dsi' , 'Software-US', 'absolute' , 'Software-US', 'accelrye' , 'Software-US', 'accelrys' , 'Software-US', 'acd' , 'Software-US', 'acdjp' , 'Software-US', 'acronisd' , 'Software-US', 'acronise' , 'Software-US', 'acronvl' , 'Software-US', 'adbevlus' , 'Software-US', 'adobe' , 'Software-US', 'adobevol' , 'Software-US', 'adsk' , 'Software-US', 'adskeren' , 'Software-US', 'adskereu' ,
  'Software-US', 'adskrslr' , 'Software-US', 'aladdJP' , 'Software-US', 'aliphcom' , 'CE-US', 'allume' , 'Software-US', 'alwil' , 'Software-EMEA', 'alwilbr' , 'Software-EMEA', 'alwiljp' , 'Software-EMEA', 'api' , 'Software-US', 'aspyr' , 'Gaming-US', 'atina' , 'CE-US', 'ATLCCP050925' , 'Software-US', 'attdrn' , 'Software-US', 'avantsta' , 'Software-US', 'averatec' , 'CE-US', 'avery' , 'Software-US', 'avg' , 'Software-EMEA', 'avira' , 'Software-EMEA', 'avlemea' , 'Software-US', 'avleuweb' , 'Software-US', 'bbygames' , 'Gaming-US', 'bbygeek' , 'Software-US', 'bbyus' , 'Software-US', 'bennetts' , 'Software-US', 'benqeu' , 'CE-EMEA', 'benqna' , 'CE-US', 'benqus' , 'CE-US', 'bobjamer' , 'Software-US', 'bobjapac' , 'Software-US', 'bobjapan' , 'Software-US', 'bobjasia' , 'Software-US', 'bobjects' , 'Software-US', 'bobjemea' , 'Software-US', 'bobjoem' , 'Software-US', 'bobjsubs' , 'Software-US', 'bobjvolu' , 'Software-US', 'borland' , 'Software-US', 'borlande' , 'Software-EMEA', 'bostona' ,
  'CE-US', 'bostonpr' , 'CE-US', 'broder' , 'Software-US', 'brook' , 'Software-US', 'ca' , 'Software-US', 'cablesun' , 'CE-US', 'caconsum' , 'Software-US', 'cadpro' , 'Software-US', 'cajapan' , 'Software-US', 'canon' , 'CE-EMEA', 'canoncon' , 'CE-EMEA', 'capac' , 'Software-US', 'capcomus' , 'Gaming-US', 'caportal' , 'Software-US', 'captaris' , 'Software-US', 'carbonit' , 'Software-US', 'cathreat' , 'Software-US', 'cdvusa' , 'Gaming-US', 'CEHP' , 'CE-US', 'celceo' , 'Software-US', 'cimmetry' , 'Software-US', 'circuitc' , 'Software-US', 'citrixtr' , 'Software-US', 'citrixus' , 'Software-US', 'cizer' , 'Software-US', 'clink' , 'Software-EMEA', 'clinkeu' , 'Software-EMEA', 'clinkjp' , 'Software-EMEA', 'clinkus' , 'Software-EMEA', 'cogenmed' , 'Software-US', 'Compwrld' , 'Software-US', 'comtrol' , 'CE-US', 'credoint' , 'Software-US', 'crelapac' , 'Software-EMEA', 'creo' , 'Software-US', 'cyberpat' , 'Software-US', 'cybscrub' , 'Software-US', 'cywee' , 'CE-EMEA', 'datadir' , 'Software-US',
  'defaultorganization' , 'Software-EMEA', 'demosft2' , 'Software-US', 'devdepot' , 'Software-US', 'digibdrn' , 'Software-US', 'dixons' , 'Software-US', 'dlink' , 'CE-US', 'dlinkdv' , 'Software-US', 'dmhold' , 'CE-US', 'dndi' , 'Gaming-US', 'drivedrn' , 'Software-US', 'drobo' , 'CE-US', 'droboeu' , 'CE-US', 'drthink' , 'Software-US', 'dsafetes' , 'Software-US', 'dwatchau' , 'Software-US', 'e52009New' , 'Software-EMEA', 'e52010New' , 'Software-EMEA', 'e5Attrition' , 'Software-EMEA', 'e5SW2009New' , 'Software-EMEA', 'e5SW2010New' , 'Software-EMEA', 'ea' , 'Gaming-US', 'eaapac' , 'Gaming-EMEA', 'eade' , 'Gaming-EMEA', 'eaemea' , 'Gaming-EMEA', 'eajapan' , 'Gaming-EMEA', 'eara' , 'Gaming-EMEA', 'easa' , 'Gaming-EMEA', 'eatw' , 'Gaming-EMEA', 'eeyeinc' , 'Software-US', 'ekconinf' , 'CE-US', 'ekconsap' , 'CE-US', 'ekconsca' , 'CE-US', 'ekconseu' , 'CE-US', 'ekconsus' , 'CE-US', 'ekinfcsr' , 'CE-US', 'elanguag' , 'Software-US', 'embarcad' , 'Software-US', 'emerfile' , 'Software-US',
  'empire' , 'Gaming-US', 'eplabs' , 'Software-US', 'es' , 'Software-US', 'es_784' , 'Software-US', 'es_784esubs' , 'Software-US', 'es_794' , 'Software-US', 'es_794esubs' , 'Software-US', 'ets' , 'Software-US', 'eyefi' , 'CE-US', 'eyefisub' , 'CE-US', 'falconst' , 'Software-US', 'famatech' , 'Software-EMEA', 'fartech' , 'Software-US', 'filebdrn' , 'Software-US', 'filestre' , 'Software-US', 'fisherp' , 'Software-US', 'flatburg' , 'Software-US', 'flcnstr' , 'Software-US', 'fredrick' , 'Software-US', 'freezdrn' , 'Software-US', 'fstone' , 'Software-US', 'fstonetw' , 'Software-US', 'fujitsu' , 'CE-US', 'gamez' , 'Software-US', 'gatewdrn' , 'Software-US', 'gdata' , 'Software-US', 'geniesof' , 'Software-EMEA', 'giken' , 'Software-EMEA', 'gikenls' , 'Software-EMEA', 'gldnbts' , 'Software-US', 'globalss' , 'Software-US', 'globalth' , 'Software-US', 'gzdd' , 'Software-US', 'headplay' , 'CE-US', 'hearme' , 'Software-US', 'hfmbooks' , 'Software-US', 'hfmedia' , 'Software-US', 'hpappli' ,
  'CE-US', 'idmcomp' , 'Software-US', 'igs' , 'Software-US', 'imsisoft' , 'Software-US', 'incomedi' , 'Software-EMEA', 'infocus' , 'Software-EMEA', 'intelacc' , 'CE-EMEA', 'intelde' , 'Software-US', 'intelna' , 'Software-US', 'intelus' , 'Software-US', 'intuitch' , 'Software-US', 'iogear' , 'CE-US', 'iolo' , 'Software-US', 'iriseinc' , 'Software-US', 'is3' , 'Software-US', 'j2global' , 'Software-US', 'jbrains' , 'Software-EMEA', 'kasperbr' , 'Software-EMEA', 'kasperde' , 'Software-EMEA', 'kaspergl' , 'Software-EMEA', 'kaspersk' , 'Software-EMEA', 'kasperuk' , 'Software-EMEA', 'kasperus' , 'Software-EMEA', 'kensing' , 'CE-US', 'kensinus' , 'CE-US', 'kmt' , 'Software-US', 'kodak' , 'CE-US', 'kpgraph' , 'CE-US', 'kriegs' , 'Software-US', 'ksekine' , 'Software-US', 'laplink' , 'Software-US', 'laughing' , 'Software-US', 'lavasoft' , 'Software-EMEA', 'liftmedi' , 'Software-US', 'lmtedtn' , 'Gaming-US', 'logib2c' , 'CE-US', 'logica' , 'CE-US', 'logieu' , 'CE-US', 'logitw' , 'CE-US',
  'logius' , 'CE-US', 'loguears' , 'CE-US', 'lominger' , 'Software-US', 'lucion' , 'Software-US', 'luna' , 'Software-US', 'macxware' , 'Software-US', 'maderdrn' , 'Software-US', 'matty' , 'Gaming-US', 'mcafee' , 'Software-EMEA', 'method' , 'Software-US', 'midway' , 'Gaming-US', 'mindjet' , 'Software-US', 'mindjeta' , 'Software-US', 'mindjete' , 'Software-US', 'msmacosx' , 'Software-US', 'msrdev' , 'Software-US', 'mysql' , 'Software-US', 'NaVisionManualAdj' , 'Software-EMEA', 'netgear' , 'CE-US', 'netgrevl' , 'CE-US', 'netgsoft' , 'CE-US', 'newegg' , 'Software-US', 'nokiait' , 'CE-EMEA', 'nokiamx' , 'CE-US', 'norman' , 'Software-EMEA', 'normanrs' , 'Software-EMEA', 'novell' , 'Software-US', 'novelleu' , 'Software-US', 'novelren' , 'Software-US', 'nuaeduau' , 'Software-EMEA', 'nuaedude' , 'Software-EMEA', 'nuaeduuk' , 'Software-EMEA', 'nuanceeu' , 'Software-EMEA', 'nuanceus' , 'Software-US', 'nuancevl' , 'Software-US', 'nuanvljp' , 'Software-US', 'nuaresau' , 'Software-US', 'nvidia' ,
  'Gaming-US', 'nvidiadv' , 'Gaming-US', 'orgchart' , 'Software-US', 'osss' , 'Software-US', 'pacifweb' , 'Software-US', 'pando' , 'Software-US', 'para' , 'Software-US', 'paralone' , 'Software-US', 'parastor' , 'Software-US', 'pcmag' , 'Software-US', 'pcprouk' , 'Software-US', 'pcss' , 'Software-US', 'pctools' , 'Software-EMEA', 'pcwordrn' , 'Software-US', 'pentaxeu' , 'CE-EMEA', 'photoid' , 'Software-US', 'piestore' , 'Software-EMEA', 'pinnacle' , 'Software-US', 'pinnapac' , 'Software-EMEA', 'pinnemea' , 'Software-EMEA', 'plantron' , 'Software-EMEA', 'playxper' , 'Software-US', 'polycom' , 'CE-US', 'primagam' , 'Gaming-US', 'prode' , 'Software-EMEA', 'promt' , 'Software-US', 'ptc' , 'Software-US', 'ptcja' , 'Software-US', 'ptcstore' , 'Software-US', 'ptronics' , 'Software-EMEA', 'quantum' , 'CE-US', 'quark' , 'Software-US', 'quarkap' , 'Software-US', 'quarkeu' , 'Software-US', 'quarkjp' , 'Software-US', 'rapidsol' , 'Software-EMEA', 'razerusa' , 'CE-EMEA', 'realtime' , 'Gaming-US',
  'regnowdr' , 'Software-US', 'rimmktpl' , 'CE-US', 'rlusion' , 'Software-EMEA', 'roboblit' , 'Gaming-US', 'rpeeub2c' , 'CE-EMEA', 'rpeeuemp' , 'CE-EMEA', 'rpeeuexp' , 'CE-EMEA', 'rpeeup' , 'CE-EMEA', 'rpeusb2c' , 'CE-US', 'rpeusemp' , 'CE-US', 'rpeusp' , 'CE-US', 'samca' , 'CE-US', 'samppus' , 'CE-US', 'samsung' , 'CE-US', 'sandtink' , 'Gaming-US', 'sauerdan' , 'Software-US', 'scansoft' , 'Software-US', 'scsoftAP' , 'Software-US', 'sdeppus' , 'CE-US', 'sdffca' , 'Software-US', 'sdffus' , 'Software-US', 'sdiskca' , 'CE-US', 'sdiskeu' , 'CE-US', 'sdiskuk' , 'CE-US', 'sdiskus' , 'CE-US', 'sennheis' , 'CE-EMEA', 'sereniti' , 'Software-US', 'sfbaydrn' , 'Software-US', 'sfinanz' , 'Software-EMEA', 'sgateeu' , 'CE-US', 'sgateus' , 'CE-US', 'sgeppus' , 'CE-US', 'shareit' , 'Software-EMEA', 'shure' , 'CE-US', 'simtel' , 'Software-US', 'sits' , 'Software-US', 'skypeeu' , 'CE-EMEA', 'skypeeuc' , 'CE-EMEA', 'slingbox' , 'CE-US', 'slingjp' , 'CE-US', 'slither' , 'Gaming-US', 'smobile' ,
  'Software-US', 'socket' , 'CE-US', 'softarch' , 'Software-US', 'softonic' , 'Software-US', 'software' , 'Software-US', 'sol' , 'Software-US', 'sonic' , 'Software-US', 'sonicbr' , 'Software-US', 'soniccn' , 'Software-US', 'sonicjp' , 'Software-US', 'sonicrox' , 'Software-US', 'sonicvlp' , 'Software-US', 'sonimtec' , 'Software-US', 'SoundPix' , 'Software-US', 'spcworld' , 'Software-US', 'speakint' , 'Gaming-US', 'sqenixus' , 'Gaming-US', 'srategyf' , 'Gaming-US', 'stellar' , 'Software-EMEA', 'stomper' , 'Software-US', 'summsoft' , 'Software-US', 'sun' , 'Software-US', 'sunjapan' , 'Software-US', 'sunspot' , 'Software-US', 'sunspotj' , 'Software-US', 'sunstor' , 'Software-US', 'suntest' , 'Software-US', 'supremer' , 'Software-US', 'swstore' , 'Software-US', 'systran' , 'Software-US', 'systsoft' , 'Software-US', 'take2' , 'Software-US', 'targusde' , 'CE-US', 'targuses' , 'CE-US', 'targusfr' , 'CE-US', 'targusit' , 'CE-US', 'targusuk' , 'CE-US', 'targusus' , 'CE-US', 'taxcut' ,
  'Software-US', 'techsmit' , 'Software-EMEA', 'tenasys' , 'Software-US', 'thq' , 'Gaming-US', 'timegate' , 'Software-US', 'tivo' , 'Software-US', 'tmamer' , 'Software-US', 'tmapac' , 'Software-US', 'tmemea' , 'Software-EMEA', 'tmjpoem' , 'Software-US', 'tmoemap' , 'Software-US', 'tmoemas' , 'Software-US', 'tmoemem' , 'Software-EMEA', 'tmoemjp' , 'Software-US', 'tmpsap' , 'Software-US', 'tmpseu' , 'Software-EMEA', 'tmpsjp' , 'Software-US', 'tmpsus' , 'Software-US', 'tmsbap' , 'Software-EMEA', 'tmsbeu' , 'Software-EMEA', 'tmsboema' , 'Software-US', 'tmsboeme' , 'Software-EMEA', 'tmsboemj' , 'Software-US', 'tmsboemn' , 'Software-US', 'tmtsecur' , 'Software-US', 'tomtom' , 'CE-US', 'transpar' , 'Software-US', 'trend' , 'Software-US', 'trendcn' , 'Software-US', 'trendjp' , 'Software-US', 'trendoem' , 'Software-US', 'trendsb' , 'Software-US', 'tripwire' , 'Software-US', 'trisyner' , 'Gaming-US', 'tuneup' , 'Software-EMEA', 'turbine' , 'Gaming-US', 'ubiemea' , 'Gaming-EMEA', 'ubina' ,
  'Gaming-US', 'ubisoft' , 'Gaming-US', 'uniblue' , 'Software-EMEA', 'unica' , 'Software-US', 'valusoft' , 'Gaming-US', 'vcom' , 'Software-US', 'verisign' , 'Software-US', 'vidpro' , 'Software-US', 'vmware' , 'Software-US', 'vmwde' , 'Software-US', 'vmwjp' , 'Software-US', 'vobissa' , 'Software-US', 'wdau' , 'CE-US', 'wdeu' , 'CE-US', 'wdus' , 'CE-US', 'webrootj' , 'Software-EMEA', 'webss' , 'Software-US', 'wgtech' , 'CE-US', 'winamp' , 'Software-US', 'worksaff' , 'Software-US', 'workshar' , 'Software-US', 'wugnet' , 'Software-US', 'xeriton' , 'Software-US', 'zeevee' , 'CE-US', 'zvue' , 'Software-US', '101009' , 'Symantec', '101110' , 'Symantec', '26492' , 'Symantec', '27674' , 'Symantec', '27675' , 'Symantec', '27676' , 'Symantec', '27677' , 'Symantec', '27678' , 'Symantec', '27679' , 'Symantec', '27680' , 'Symantec', '27681' , 'Symantec', '27682' , 'Symantec', '27683' , 'Symantec', '27685' , 'Symantec', '27686' , 'Symantec', '27687' , 'Symantec', '27688' , 'Symantec', '27760' ,
  'Symantec', '27940' , 'Symantec', '27941' , 'Symantec', '34175' , 'Symantec', '35335' , 'Symantec', '36995' , 'Symantec', '37771' , 'Symantec', '38512' , 'Symantec', '38612' , 'Symantec', '38613' , 'Symantec', '38614' , 'Symantec', '38674' , 'Symantec', '38872' , 'Symantec', '40405' , 'Symantec', '40406' , 'Symantec', '40407' , 'Symantec', '40408' , 'Symantec', '40409' , 'Symantec', '40586' , 'Symantec', '41168' , 'Symantec', '41186' , 'Symantec', '41187' , 'Symantec', '41188' , 'Symantec', '41286' , 'Symantec', '42305' , 'Symantec', '42665' , 'Symantec', '43045' , 'Symantec', '43365' , 'Symantec', '43485' , 'Symantec', '43486' , 'Symantec', '46205' , 'Symantec', '46206' , 'Symantec', '46207' , 'Symantec', '46208' , 'Symantec', '47925' , 'Symantec', '48125' , 'Symantec', '48146' , 'Symantec', '48405' , 'Symantec', '48406' , 'Symantec', '48407' , 'Symantec', '48408' , 'Symantec', '49165' , 'Symantec', '49166' , 'Symantec', '49265' , 'Symantec', '49465' , 'Symantec', '49466' ,
  'Symantec', '49467' , 'Symantec', '49468' , 'Symantec', '49886' , 'Symantec', '49887' , 'Symantec', '49925' , 'Symantec', '49926' , 'Symantec', '49928' , 'Symantec', '49931' , 'Symantec', '49932' , 'Symantec', '49933' , 'Symantec', '49934' , 'Symantec', '49935' , 'Symantec', '49945' , 'Symantec', '49946' , 'Symantec', '49947' , 'Symantec', '49948' , 'Symantec', '49949' , 'Symantec', '49950' , 'Symantec', '49951' , 'Symantec', '49952' , 'Symantec', '49953' , 'Symantec', '49954' , 'Symantec', '49970' , 'Symantec', '49971' , 'Symantec', '49972' , 'Symantec', '49992' , 'Symantec', '49993' , 'Symantec', '49994' , 'Symantec', '49995' , 'Symantec', '49996' , 'Symantec', '49997' , 'Symantec', '49998' , 'Symantec', '49999' , 'Symantec', '50727' , 'Symantec', '50905' , 'Symantec', '50906' , 'Symantec', '50907' , 'Symantec', '51185' , 'Symantec', '51186' , 'Symantec', '53297' , 'Symantec', '597' , 'Symantec', '69559' , 'Symantec', '72709' , 'Symantec', '78909' , 'Symantec', '78910' ,
  'Symantec', '78911' , 'Symantec', '78912' , 'Symantec', '78913' , 'Symantec', '78914' , 'Symantec', '78915' , 'Symantec', '78916' , 'Symantec', '78917' , 'Symantec', '78918' , 'Symantec', '78919' , 'Symantec', '78920' , 'Symantec', '78921' , 'Symantec', '78922' , 'Symantec', '78923' , 'Symantec', '78924' , 'Symantec', '78925' , 'Symantec', '78926' , 'Symantec', '84408' , 'Symantec', '84409' , 'Symantec', '85008' , 'Symantec', '89908' , 'Symantec', '89909' , 'Symantec', '90009' , 'Symantec', '90708' , 'Symantec', '91108' , 'Symantec', '91609' , 'Symantec', '92612' , 'Symantec', '92615' , 'Symantec', '92617' , 'Symantec', '92619' , 'Symantec', '92620' , 'Symantec', '95009' , 'Symantec', '95010' , 'Symantec', 'symanbr' , 'Symantec', 'symanhk' , 'Symantec', 'symankr' , 'Symantec', 'symanlam' , 'Symantec', 'symantch' , 'Symantec', 'symantw' , 'Symantec', 'symeehho' , 'Symantec', 'symehp' , 'Symantec', 'symhkhho' , 'Symantec', 'symhp' , 'Symantec', 'symnahho' , 'Symantec', 'symnasmb' ,
  'Symantec', 'symnzhho' , 'Symantec', 'symsahho' , 'Symantec', 'symtbyb' , 'Symantec', 'symukoem' , 'Symantec', 'symwebsv' , 'Symantec', 'mswpus' , 'Microsoft', 'msshus' , 'Microsoft', 'mswpde' , 'Microsoft', 'msshau' , 'Microsoft', 'msmacus' , 'Microsoft', 'msshgb' , 'Microsoft', 'msshca' , 'Microsoft', 'msshde' , 'Microsoft', 'mswpmx' , 'Microsoft', 'mswpau' , 'Microsoft', 'mswpca' , 'Microsoft', 'msshfr' , 'Microsoft', 'mswpfr' , 'Microsoft', 'mswpkr' , 'Microsoft', 'mswpuk' , 'Microsoft', 'msshdk' , 'Microsoft', 'msshmx' , 'Microsoft', 'msshse' , 'Microsoft', 'msmacca' , 'Microsoft', 'msmacus2' , 'Microsoft', 'msmaceur' , 'Microsoft', 'msmacgb' , 'Microsoft', 'msshfi' , 'Microsoft', 'msmacfr' , 'Microsoft', 'msshes' , 'Microsoft', 'msshuk' , 'Microsoft', 'msshtw' , 'Microsoft', 'msshno' , 'Microsoft', 'msmacde' , 'Microsoft', 'msshbe' , 'Microsoft', 'msshnz' , 'Microsoft', 'msshkr' , 'Microsoft', 'msmacau' , 'Microsoft', 'msmacjp' , 'Microsoft', 'money' , 'Microsoft', 'msedpg' ,
  'Microsoft', 'msmacbr' , 'Microsoft', 'msmacmx' , 'Microsoft', 'msmacie' , 'Microsoft', 'msmachk' , 'Microsoft', 'msmacsg' , 'Microsoft', 'msmacnz' , 'Microsoft', 'msehupbc' , 'Microsoft', 'msedeu' , 'Microsoft', 'msshpt' , 'Microsoft', 'mskrdvd' , 'Microsoft', 'msaudvd' , 'Microsoft', 'msakai' , 'Microsoft','not_allocated')))vertical
FROM
  (SELECT division_id ,
    division_site_id ,
    merchant_descriptor ,
    SUM(DECODE(trans_type, 'sales', units))sales_units ,
    SUM(DECODE(trans_type, 'cbs', units))cb_units ,
    SUM(DECODE(trans_type, 'cbs', units)/ DECODE(trans_type, 'sales', units)) unit_cbr ,
    SUM(DECODE(trans_type, 'sales', amount))sales_amount ,
    SUM(DECODE(trans_type, 'cbs', amount))cb_amount ,
    SUM(DECODE(trans_type, 'cbs', amount)/ DECODE(trans_type, 'sales', amount)) amount_cbr ,
    SUM(DECODE(code,'37',units, '40',units, '49',units, '57',units, '61',units, '12',units, '62',units,'83',units, '4837',units, '4847',units, 0))                       AS num_fraud ,
    SUM(DECODE(code,'54',units, 'T',units, 'RJ',units, '08',units, '4801',units, 0))                                                                                     AS num_misc_cs ,
    SUM(DECODE(code,'63',units, '75',units, '4863',units, 0))                                                                                                            AS num_unrec ,
    SUM(DECODE(code,'30',units, '55',units, '59',units, '4855',units, '01',units, '90',units, 0))                                                                        AS num_not_received ,
    SUM(DECODE(code,'41',units, 0))                                                                                                                                      AS num_cancel_recurring ,
    SUM(DECODE(code,'53',units, 0))                                                                                                                                      AS num_not_as_described ,
    SUM(DECODE(code,'60',units, '85',units, '86',units, 0))                                                                                                              AS num_no_credit ,
    SUM(DECODE(code,'56',units, 0))                                                                                                                                      AS num_defective ,
    SUM(DECODE(code,'34',units, '4534',units, '4348',units, '82',units, 0))                                                                                              AS num_duplicate ,
    SUM(DECODE(code,'35',units, '42',units, '71',units, '72',units, '73',units, '31',units, '80',units, '76',units, '07',units, '4507',units, '77',units, 0))            AS num_auth ,
    SUM(DECODE(code,'37',amount, '40',amount, '49',amount, '57',amount, '61',amount, '12',amount, '62',amount,'83',amount, '4837',amount, '4847',amount, 0))             AS amount_fraud ,
    SUM(DECODE(code,'54',amount, 'T',amount, 'RJ',amount, '08',amount, '4801',amount, 0))                                                                                AS amount_misc_cs ,
    SUM(DECODE(code,'63',amount, '75',amount, '4863',amount, 0))                                                                                                         AS amount_unrec ,
    SUM(DECODE(code,'30',amount, '55',amount, '59',amount, '4855',amount, '01',amount, '90',amount, 0))                                                                  AS amount_not_received ,
    SUM(DECODE(code,'41',amount, 0))                                                                                                                                     AS amount_cancel_recurring ,
    SUM(DECODE(code,'53',amount, 0))                                                                                                                                     AS amount_not_as_described ,
    SUM(DECODE(code,'60',amount, '85',amount, '86',amount, 0))                                                                                                           AS amount_no_credit ,
    SUM(DECODE(code,'56',amount, 0))                                                                                                                                     AS amount_defective ,
    SUM(DECODE(code,'34',amount, '4534',amount, '4348',amount, '82',amount, 0))                                                                                          AS amount_duplicate ,
    SUM(DECODE(code,'35',amount, '42',amount, '71',amount, '72',amount, '73',amount, '31',amount, '80',amount, '76',amount, '07',amount, '4507',amount, '77',amount, 0)) AS amount_auth
  FROM
    (SELECT division_id ,merchant_descriptor,
      DECODE(division_id, 'atlantic' , division_site_id, 'ccnow' , division_site_id, 'commerce5' , merchant_descriptor, 'element5' , division_site_id, 'esellerate' , division_site_id, 'pacific' , division_site_id, 'regnet' , division_site_id, 'regnow' , division_site_id, 'regsoft' , merchant_descriptor, 'setsystems' , merchant_descriptor, 'swreg' , division_site_id) division_site_id ,
      'null' code ,
      'sales' trans_type ,
      COUNT(cpg_transaction_id)units ,
      SUM(rpt.payment_amount/der.exchange_rate_num)amount
    FROM rcn_payment_transaction rpt,
      currency_exchange_sfact_vw der
    WHERE TRUNC(der.effective_date) = rpt.settlement_date
    AND rpt.TRANSACTION_CURRENCY    = der.to_currency_code
    AND transaction_type           IN ('Settle')
        and creation_date > &&date1
    AND settlement_date BETWEEN
      &&date1 AND
      &&date2
    AND division_id IN ('commerce5','element5','esellerate','pacific','regnow','swreg')
      --and  payment_method_id in ('MasterCard', 'Visa')
    AND status = 'Completed'
    GROUP BY division_id ,merchant_descriptor,
      DECODE(division_id, 'atlantic' , division_site_id, 'ccnow' , division_site_id, 'commerce5' , merchant_descriptor, 'element5' , division_site_id, 'esellerate' , division_site_id, 'pacific' , division_site_id, 'regnet' , division_site_id, 'regnow', division_site_id, 'regsoft' , merchant_descriptor, 'setsystems' , merchant_descriptor, 'swreg' , division_site_id) ,
      'null' ,
      'sales'
    UNION ALL
    SELECT division_id ,merchant_descriptor,
      DECODE(division_id, 'atlantic' , division_site_id, 'ccnow' , division_site_id, 'commerce5' , merchant_descriptor, 'element5' , division_site_id, 'esellerate' , division_site_id, 'pacific' , division_site_id, 'regnet' , division_site_id, 'regnow', division_site_id, 'regsoft' , merchant_descriptor, 'setsystems' , merchant_descriptor, 'swreg' , division_site_id) division_site_id ,
      reason_code ,
      'cbs' ,
      COUNT(cpg_transaction_id) units ,
      SUM(usd) amount
    FROM
      (SELECT rpt.CPG_TRANSACTION_ID ,
        rpt.division_order_id AS order_id ,
        rpt.division_site_id ,
        rpt.division_id ,
        rpt.payment_processor_name ,
        rpt.merchant_descriptor ,
        rpt.order_date ,
        extract(MONTH FROM rpt.order_date)
        || '-'
        || extract(YEAR FROM rpt.order_date) AS order_month ,
        rpt.settlement_date ,
        extract(MONTH FROM rpt.settlement_date)
        || '-'
        || extract(YEAR FROM rpt.settlement_date) cb_month ,
        rpt.transaction_type ,
        rpt.payment_method_id ,
        rpt.payment_amount                         AS amount ,
        (rpt.payment_amount/der.exchange_rate_num) AS usd ,
        rpt.transaction_currency                   AS currency ,
        rpt.status ,
        rpt.response_code AS reason_code ,
        DECODE(rpt.response_code, '1' , 'Non-Fraud','2' , 'Non-Fraud','4' , 'Non-Fraud','5' , 'Non-Fraud','6' , 'Non-Fraud','7' , 'Non-Fraud','8' , 'Non-Fraud','9' , 'Non-Fraud','10' , 'Non-Fraud','12' , 'Non-Fraud','13' , 'Non-Fraud','14' , 'Non-Fraud','22' , 'Fraud','28' , 'Non-Fraud','30' , 'Non-Fraud','31' , 'Non-Fraud','34' , 'Non-Fraud','35' , 'Non-Fraud','37' , 'Fraud','40' , 'Non-Fraud','41' , 'Non-Fraud','42' , 'Non-Fraud','45' , 'Non-Fraud','46' , 'Non-Fraud','47' , 'Non-Fraud','50' , 'Non-Fraud','53' , 'Non-Fraud','55' , 'Non-Fraud','59' , 'Non-Fraud','60' , 'Non-Fraud','62' , 'Non-Fraud','63' , 'Unrecognized','71' , 'Non-Fraud','72' , 'Non-Fraud','73' , 'Non-Fraud','74' , 'Non-Fraud','75' , 'Unrecognized','77' , 'Non-Fraud','80' , 'Non-Fraud','81' , 'Non-Fraud','82' , 'Non-Fraud','83' , 'Fraud','85' , 'Non-Fraud','86' , 'Non-Fraud','93' , 'Non-Fraud','98' , 'Non-Fraud','100' , 'Non-Fraud','1008' , 'Non-Fraud','1010' , 'Non-Fraud','4507' , 'Non-Fraud','4512' , 'Non-Fraud',
        '4516' , 'Non-Fraud','4517' , 'Non-Fraud','4544' , 'Non-Fraud','4554' , 'Non-Fraud','4753' , 'Non-Fraud','4801' , 'Non-Fraud','4808' , 'Non-Fraud','4834' , 'Non-Fraud','4835' , 'Non-Fraud','4837' , 'Fraud','4841' , 'Non-Fraud','4842' , 'Non-Fraud','4853' , 'Non-Fraud','4855' , 'Non-Fraud','4859' , 'Non-Fraud','4860' , 'Non-Fraud','4862' , 'Non-Fraud','4863' , 'Unrecognized','9050' , 'Non-Fraud','9051' , 'Non-Fraud','9052' , 'Non-Fraud','9053' , 'Non-Fraud','9055' , 'Non-Fraud','15 - CHRG BK PU' , 'Non-Fraud','16 - CHRG BK CR' , 'Non-Fraud','5 - SALE' , 'Non-Fraud','AP' , 'Non-Fraud','CR' , 'Non-Fraud','DA' , 'Non-Fraud','DP' , 'Non-Fraud','Fraud' , 'Fraud','Non-Fraud' , 'Non-Fraud','R10' , 'Non-Fraud','RJ' , 'Non-Fraud','RM' , 'Non-Fraud','RN2' , 'Non-Fraud','T' , 'Non-Fraud','T1106' , 'Fraud','T1201' , 'Fraud','U23' , 'Non-Fraud','U31' , 'Non-Fraud','U32' , 'Fraud','UA01' , 'Non-Fraud','UA02' , 'Non-Fraud','UA30' , 'Non-Fraud','UA31' , 'Non-Fraud','UA32' , 'Fraud',
        'Inquiry by PayPal' , 'Non-Fraud','Item not received' , 'Non-Fraud','Merchandise' , 'Non-Fraud','Non-receipt' , 'Non-Fraud','Unauthorized' , 'Fraud','Unauthorized payment' , 'Fraud','n/a' , 'Non-Fraud','other') AS CB_Reason ,
        rpt.usage_code ,
        rpt.bank_name ,
        rpt.recurring_flag ,
        rpt.customer_email ,
        rpt.customer_ip ,
        (SELECT SUM(rpt.payment_amount/der.exchange_rate_num)
        FROM rcn_payment_transaction
        WHERE transaction_type IN ('Settle')
        AND status              = 'Completed'
        AND division_order_id   = rpt.division_order_id
        AND rownum              < 2
        ) AS Settle_AMT ,
        (SELECT SUM(rpt.payment_amount/der.exchange_rate_num)
        FROM rcn_payment_transaction
        WHERE transaction_type IN ('ChargeBack')
        AND status              = 'Completed'
        AND division_order_id   = rpt.division_order_id
        AND rownum              < 2
        ) AS CB_AMT
      FROM rcn_payment_transaction rpt,
        currency_exchange_sfact_vw der
      WHERE TRUNC(der.effective_date) = rpt.settlement_date
      AND rpt.TRANSACTION_CURRENCY    = der.to_currency_code
      AND cpg_transaction_id         IN
        (SELECT
          /*junk.settlement_date, junk.division_order_id, junk.payment_amount , junk.division_id, */
          (
          SELECT cpg_transaction_id
          FROM rcn_payment_transaction
          WHERE transaction_type IN ('ChargeBack')
          AND division_order_id   = junk.division_order_id
          AND payment_amount      = junk.payment_amount
          AND rownum              < 2
          ) AS trans_id
        FROM
          ( SELECT DISTINCT
            (SELECT MIN(settlement_date)
            FROM rcn_payment_transaction
            WHERE transaction_type IN ('ChargeBack')
            AND division_order_id   = rpt.division_order_id
            )AS settlement_date,
            division_order_id,
            payment_amount,
            division_id,
            status
          FROM rcn_payment_transaction rpt
          WHERE division_order_id IN
            (SELECT division_order_id
            FROM rcn_payment_transaction
            WHERE transaction_type IN ('ChargeBack')
            AND response_code NOT  IN ('98', 'RJ', 'RV')
                and creation_date > &&date1
            AND settlement_date BETWEEN
              &&date1 AND
              &&date2
            AND division_id IN ('commerce5','element5','esellerate','pacific','regnow','swreg')
              --and     payment_method_id in ('MasterCard', 'Visa')
            AND (usage_code IS NULL
            OR usage_code    = '1')
            )
          AND transaction_type IN ('ChargeBack')
          AND status            = 'Completed'
          ORDER BY division_order_id,
            settlement_date
          ) junk
        WHERE settlement_date BETWEEN
          &&date1 AND
          &&date2
        )
      AND status = 'Completed'
      )
    GROUP BY division_id ,merchant_descriptor,
      DECODE(division_id, 'atlantic' , division_site_id, 'ccnow' , division_site_id, 'commerce5' , merchant_descriptor, 'element5' , division_site_id, 'esellerate' , division_site_id, 'pacific' , division_site_id, 'regnet' , division_site_id, 'regnow', division_site_id, 'regsoft' , merchant_descriptor, 'setsystems' , merchant_descriptor, 'swreg' , division_site_id) ,
      reason_code ,
      'cbs'
    ) temp
  GROUP BY division_id ,merchant_descriptor,
    division_site_id ,
    'Site_name'
  ) data1 ,
  (SELECT division_id ,
    COUNT(cpg_transaction_id) units ,
    SUM(usd) amount
  FROM
    (SELECT rpt.CPG_TRANSACTION_ID ,
      rpt.division_order_id AS order_id ,
      rpt.division_site_id ,
      rpt.division_id ,
      rpt.payment_processor_name ,
      rpt.merchant_descriptor ,
      rpt.order_date ,
      extract(MONTH FROM rpt.order_date)
      || '-'
      || extract(YEAR FROM rpt.order_date) AS order_month ,
      rpt.settlement_date ,
      extract(MONTH FROM rpt.settlement_date)
      || '-'
      || extract(YEAR FROM rpt.settlement_date) cb_month ,
      rpt.transaction_type ,
      rpt.payment_method_id ,
      rpt.payment_amount                         AS amount ,
      (rpt.payment_amount/der.exchange_rate_num) AS usd ,
      rpt.transaction_currency                   AS currency ,
      rpt.status ,
      rpt.response_code AS reason_code ,
      DECODE(rpt.response_code, '1' , 'Non-Fraud','2' , 'Non-Fraud','4' , 'Non-Fraud','5' , 'Non-Fraud','6' , 'Non-Fraud','7' , 'Non-Fraud','8' , 'Non-Fraud','9' , 'Non-Fraud','10' , 'Non-Fraud','12' , 'Non-Fraud','13' , 'Non-Fraud','14' , 'Non-Fraud','22' , 'Fraud','28' , 'Non-Fraud','30' , 'Non-Fraud','31' , 'Non-Fraud','34' , 'Non-Fraud','35' , 'Non-Fraud','37' , 'Fraud','40' , 'Non-Fraud','41' , 'Non-Fraud','42' , 'Non-Fraud','45' , 'Non-Fraud','46' , 'Non-Fraud','47' , 'Non-Fraud','50' , 'Non-Fraud','53' , 'Non-Fraud','55' , 'Non-Fraud','59' , 'Non-Fraud','60' , 'Non-Fraud','62' , 'Non-Fraud','63' , 'Unrecognized','71' , 'Non-Fraud','72' , 'Non-Fraud','73' , 'Non-Fraud','74' , 'Non-Fraud','75' , 'Unrecognized','77' , 'Non-Fraud','80' , 'Non-Fraud','81' , 'Non-Fraud','82' , 'Non-Fraud','83' , 'Fraud','85' , 'Non-Fraud','86' , 'Non-Fraud','93' , 'Non-Fraud','98' , 'Non-Fraud','100' , 'Non-Fraud','1008' , 'Non-Fraud','1010' , 'Non-Fraud','4507' , 'Non-Fraud','4512' , 'Non-Fraud',
      '4516' , 'Non-Fraud','4517' , 'Non-Fraud','4544' , 'Non-Fraud','4554' , 'Non-Fraud','4753' , 'Non-Fraud','4801' , 'Non-Fraud','4808' , 'Non-Fraud','4834' , 'Non-Fraud','4835' , 'Non-Fraud','4837' , 'Fraud','4841' , 'Non-Fraud','4842' , 'Non-Fraud','4853' , 'Non-Fraud','4855' , 'Non-Fraud','4859' , 'Non-Fraud','4860' , 'Non-Fraud','4862' , 'Non-Fraud','4863' , 'Unrecognized','9050' , 'Non-Fraud','9051' , 'Non-Fraud','9052' , 'Non-Fraud','9053' , 'Non-Fraud','9055' , 'Non-Fraud','15 - CHRG BK PU' , 'Non-Fraud','16 - CHRG BK CR' , 'Non-Fraud','5 - SALE' , 'Non-Fraud','AP' , 'Non-Fraud','CR' , 'Non-Fraud','DA' , 'Non-Fraud','DP' , 'Non-Fraud','Fraud' , 'Fraud','Non-Fraud' , 'Non-Fraud','R10' , 'Non-Fraud','RJ' , 'Non-Fraud','RM' , 'Non-Fraud','RN2' , 'Non-Fraud','T' , 'Non-Fraud','T1106' , 'Fraud','T1201' , 'Fraud','U23' , 'Non-Fraud','U31' , 'Non-Fraud','U32' , 'Fraud','UA01' , 'Non-Fraud','UA02' , 'Non-Fraud','UA30' , 'Non-Fraud','UA31' , 'Non-Fraud','UA32' , 'Fraud',
      'Inquiry by PayPal' , 'Non-Fraud','Item not received' , 'Non-Fraud','Merchandise' , 'Non-Fraud','Non-receipt' , 'Non-Fraud','Unauthorized' , 'Fraud','Unauthorized payment' , 'Fraud','n/a' , 'Non-Fraud','other') AS CB_Reason ,
      rpt.usage_code ,
      rpt.bank_name ,
      rpt.recurring_flag ,
      rpt.customer_email ,
      rpt.customer_ip ,
      (SELECT SUM(rpt.payment_amount/der.exchange_rate_num)
      FROM rcn_payment_transaction
      WHERE transaction_type IN ('Settle')
      AND status              = 'Completed'
      AND division_order_id   = rpt.division_order_id
      AND rownum              < 2
      ) AS Settle_AMT ,
      (SELECT SUM(rpt.payment_amount/der.exchange_rate_num)
      FROM rcn_payment_transaction
      WHERE transaction_type IN ('ChargeBack')
      AND status              = 'Completed'
      AND division_order_id   = rpt.division_order_id
      AND rownum              < 2
      ) AS CB_AMT
    FROM rcn_payment_transaction rpt,
      currency_exchange_sfact_vw der
    WHERE TRUNC(der.effective_date) = rpt.settlement_date
    AND rpt.TRANSACTION_CURRENCY    = der.to_currency_code
    AND cpg_transaction_id         IN
      (SELECT
        /*junk.settlement_date, junk.division_order_id, junk.payment_amount , junk.division_id, */
        (
        SELECT cpg_transaction_id
        FROM rcn_payment_transaction
        WHERE transaction_type IN ('ChargeBack')
        AND division_order_id   = junk.division_order_id
        AND payment_amount      = junk.payment_amount
        AND rownum              < 2
        ) AS trans_id
      FROM
        ( SELECT DISTINCT
          (SELECT MIN(settlement_date)
          FROM rcn_payment_transaction
          WHERE transaction_type IN ('ChargeBack')
          AND division_order_id   = rpt.division_order_id
          )AS settlement_date,
          division_order_id,
          payment_amount,
          division_id,
          status
        FROM rcn_payment_transaction rpt
        WHERE division_order_id IN
          (SELECT division_order_id
          FROM rcn_payment_transaction
          WHERE transaction_type IN ('ChargeBack')
          AND response_code NOT  IN ('98', 'RJ', 'RV')
              and creation_date > &&date1
          AND settlement_date BETWEEN
            &&date1 AND
            &&date2
          AND division_id IN ('commerce5','element5','esellerate','pacific','regnow','swreg')
            --and     payment_method_id in ('MasterCard', 'Visa')
          AND (usage_code IS NULL
          OR usage_code    = '1')
          )
        AND transaction_type IN ('ChargeBack')
        AND status            = 'Completed'
        ORDER BY division_order_id,
          settlement_date
        ) junk
      WHERE settlement_date BETWEEN
        &&date1 AND
        &&date2
      )
    AND status = 'Completed'
    )
  GROUP BY division_id
  )plat_data2 ,
  (SELECT COUNT(cpg_transaction_id) units ,
    SUM(usd) amount
  FROM
    (SELECT rpt.CPG_TRANSACTION_ID ,
      rpt.division_order_id AS order_id ,
      rpt.division_site_id ,
      rpt.division_id ,
      rpt.payment_processor_name ,
      rpt.merchant_descriptor ,
      rpt.order_date ,
      extract(MONTH FROM rpt.order_date)
      || '-'
      || extract(YEAR FROM rpt.order_date) AS order_month ,
      rpt.settlement_date ,
      extract(MONTH FROM rpt.settlement_date)
      || '-'
      || extract(YEAR FROM rpt.settlement_date) cb_month ,
      rpt.transaction_type ,
      rpt.payment_method_id ,
      rpt.payment_amount                         AS amount ,
      (rpt.payment_amount/der.exchange_rate_num) AS usd ,
      rpt.transaction_currency                   AS currency ,
      rpt.status ,
      rpt.response_code AS reason_code ,
      DECODE(rpt.response_code, '1' , 'Non-Fraud','2' , 'Non-Fraud','4' , 'Non-Fraud','5' , 'Non-Fraud','6' , 'Non-Fraud','7' , 'Non-Fraud','8' , 'Non-Fraud','9' , 'Non-Fraud','10' , 'Non-Fraud','12' , 'Non-Fraud','13' , 'Non-Fraud','14' , 'Non-Fraud','22' , 'Fraud','28' , 'Non-Fraud','30' , 'Non-Fraud','31' , 'Non-Fraud','34' , 'Non-Fraud','35' , 'Non-Fraud','37' , 'Fraud','40' , 'Non-Fraud','41' , 'Non-Fraud','42' , 'Non-Fraud','45' , 'Non-Fraud','46' , 'Non-Fraud','47' , 'Non-Fraud','50' , 'Non-Fraud','53' , 'Non-Fraud','55' , 'Non-Fraud','59' , 'Non-Fraud','60' , 'Non-Fraud','62' , 'Non-Fraud','63' , 'Unrecognized','71' , 'Non-Fraud','72' , 'Non-Fraud','73' , 'Non-Fraud','74' , 'Non-Fraud','75' , 'Unrecognized','77' , 'Non-Fraud','80' , 'Non-Fraud','81' , 'Non-Fraud','82' , 'Non-Fraud','83' , 'Fraud','85' , 'Non-Fraud','86' , 'Non-Fraud','93' , 'Non-Fraud','98' , 'Non-Fraud','100' , 'Non-Fraud','1008' , 'Non-Fraud','1010' , 'Non-Fraud','4507' , 'Non-Fraud','4512' , 'Non-Fraud',
      '4516' , 'Non-Fraud','4517' , 'Non-Fraud','4544' , 'Non-Fraud','4554' , 'Non-Fraud','4753' , 'Non-Fraud','4801' , 'Non-Fraud','4808' , 'Non-Fraud','4834' , 'Non-Fraud','4835' , 'Non-Fraud','4837' , 'Fraud','4841' , 'Non-Fraud','4842' , 'Non-Fraud','4853' , 'Non-Fraud','4855' , 'Non-Fraud','4859' , 'Non-Fraud','4860' , 'Non-Fraud','4862' , 'Non-Fraud','4863' , 'Unrecognized','9050' , 'Non-Fraud','9051' , 'Non-Fraud','9052' , 'Non-Fraud','9053' , 'Non-Fraud','9055' , 'Non-Fraud','15 - CHRG BK PU' , 'Non-Fraud','16 - CHRG BK CR' , 'Non-Fraud','5 - SALE' , 'Non-Fraud','AP' , 'Non-Fraud','CR' , 'Non-Fraud','DA' , 'Non-Fraud','DP' , 'Non-Fraud','Fraud' , 'Fraud','Non-Fraud' , 'Non-Fraud','R10' , 'Non-Fraud','RJ' , 'Non-Fraud','RM' , 'Non-Fraud','RN2' , 'Non-Fraud','T' , 'Non-Fraud','T1106' , 'Fraud','T1201' , 'Fraud','U23' , 'Non-Fraud','U31' , 'Non-Fraud','U32' , 'Fraud','UA01' , 'Non-Fraud','UA02' , 'Non-Fraud','UA30' , 'Non-Fraud','UA31' , 'Non-Fraud','UA32' , 'Fraud',
      'Inquiry by PayPal' , 'Non-Fraud','Item not received' , 'Non-Fraud','Merchandise' , 'Non-Fraud','Non-receipt' , 'Non-Fraud','Unauthorized' , 'Fraud','Unauthorized payment' , 'Fraud','n/a' , 'Non-Fraud','other') AS CB_Reason ,
      rpt.usage_code ,
      rpt.bank_name ,
      rpt.recurring_flag ,
      rpt.customer_email ,
      rpt.customer_ip ,
      (SELECT SUM(rpt.payment_amount/der.exchange_rate_num)
      FROM rcn_payment_transaction
      WHERE transaction_type IN ('Settle')
      AND status              = 'Completed'
      AND division_order_id   = rpt.division_order_id
      AND rownum              < 2
      ) AS Settle_AMT ,
      (SELECT SUM(rpt.payment_amount/der.exchange_rate_num)
      FROM rcn_payment_transaction
      WHERE transaction_type IN ('ChargeBack')
      AND status              = 'Completed'
      AND division_order_id   = rpt.division_order_id
      AND rownum              < 2
      ) AS CB_AMT
    FROM rcn_payment_transaction rpt,
      currency_exchange_sfact_vw der
    WHERE TRUNC(der.effective_date) = rpt.settlement_date
    AND rpt.TRANSACTION_CURRENCY    = der.to_currency_code
    AND cpg_transaction_id         IN
      (SELECT
        /*junk.settlement_date, junk.division_order_id, junk.payment_amount , junk.division_id, */
        (
        SELECT cpg_transaction_id
        FROM rcn_payment_transaction
        WHERE transaction_type IN ('ChargeBack')
        AND division_order_id   = junk.division_order_id
        AND payment_amount      = junk.payment_amount
        AND rownum              < 2
        ) AS trans_id
      FROM
        ( SELECT DISTINCT
          (SELECT MIN(settlement_date)
          FROM rcn_payment_transaction
          WHERE transaction_type IN ('ChargeBack')
          AND division_order_id   = rpt.division_order_id
          )AS settlement_date,
          division_order_id,
          payment_amount,
          division_id,
          status
        FROM rcn_payment_transaction rpt
        WHERE division_order_id IN
          (SELECT division_order_id
          FROM rcn_payment_transaction
          WHERE transaction_type IN ('ChargeBack')
          AND response_code NOT  IN ('98', 'RJ', 'RV')
              and creation_date > &&date1
          AND settlement_date BETWEEN
            &&date1 AND
            &&date2
          AND division_id IN ('commerce5','element5','esellerate','pacific','regnow','swreg')
            --and     payment_method_id in ('MasterCard', 'Visa')
          AND (usage_code IS NULL
          OR usage_code    = '1')
          )
        AND transaction_type IN ('ChargeBack')
        AND status            = 'Completed'
        ORDER BY division_order_id,
          settlement_date
        ) junk
      WHERE settlement_date BETWEEN
        &&date1 AND
        &&date2
      )
    AND status = 'Completed'
    )
  )global_data
WHERE plat_data2.division_id = data1.division_id
AND data1.cb_units          IS NOT NULL
--***********************************
UNION ALL
--***********************************
SELECT data1.division_id ,
  data1.division_site_id ,
  'null' site_name ,
  data1.sales_units ,
  data1.cb_units ,
  (data1.cb_units/data1.sales_units)unit_cbr ,
  data1.sales_amount ,
  data1.cb_amount ,
  (data1.cb_amount             /data1.sales_amount) amount_cbr ,
  (data1.cb_units              /plat_data2.units) RATIO_TOTAL_PLATFORM_CB_UNITS ,
  (data1.cb_amount             /plat_data2.amount) RATIO_TOTAL_PLATFORM_CB_AMOUNT ,
  (data1.cb_units              /global_data.units)RATIO_GLOBAL_CB_UNITS ,
  (data1.cb_amount             /global_data.amount)RATIO_GLOBAL_CB_amount ,
  data1.num_fraud              /data1.cb_units num_fraud ,
  data1.num_misc_cs            /data1.cb_units num_misc_cs ,
  data1.num_unrec              /data1.cb_units num_unrec ,
  data1.num_not_received       /data1.cb_units num_not_recognized ,
  data1.num_cancel_recurring   /data1.cb_units cancel_recurring ,
  data1.num_not_as_described   /data1.cb_units not_as_described ,
  data1.num_no_credit          /data1.cb_units num_no_credit ,
  data1.num_defective          /data1.cb_units num_defective ,
  data1.num_duplicate          /data1.cb_units num_duplicate ,
  data1.num_auth               /data1.cb_units num_auth ,
  data1.amount_fraud           /data1.cb_amount amount_fraud ,
  data1.amount_misc_cs         /data1.cb_amount amount_misc_cs ,
  data1.amount_unrec           /data1.cb_amount amount_unrec ,
  data1.amount_not_received    /data1.cb_amount amount_not_recognized ,
  data1.amount_cancel_recurring/data1.cb_amount cancel_recurring ,
  data1.amount_not_as_described/data1.cb_amount not_as_described ,
  data1.amount_no_credit       /data1.cb_amount amount_no_credit ,
  data1.amount_defective       /data1.cb_amount amount_defective ,
  data1.amount_duplicate       /data1.cb_amount amount_duplicate ,
  data1.amount_auth            /data1.cb_amount amount_auth ,
  'null'
FROM
  (SELECT division_id ,
    division_site_id ,
    'Site_name'site_name ,
    SUM(DECODE(trans_type, 'sales', units))sales_units ,
    SUM(DECODE(trans_type, 'cbs', units))cb_units ,
    SUM(DECODE(trans_type, 'cbs', units)/ DECODE(trans_type, 'sales', units)) unit_cbr ,
    SUM(DECODE(trans_type, 'sales', amount))sales_amount ,
    SUM(DECODE(trans_type, 'cbs', amount))cb_amount ,
    SUM(DECODE(trans_type, 'cbs', amount)/ DECODE(trans_type, 'sales', amount)) amount_cbr ,
    SUM(DECODE(code,'37',units, '40',units, '49',units, '57',units, '61',units, '12',units, '62',units,'83',units, '4837',units, '4847',units, 0))                       AS num_fraud ,
    SUM(DECODE(code,'54',units, 'T',units, 'RJ',units, '08',units, '4801',units, 0))                                                                                     AS num_misc_cs ,
    SUM(DECODE(code,'63',units, '75',units, '4863',units, 0))                                                                                                            AS num_unrec ,
    SUM(DECODE(code,'30',units, '55',units, '59',units, '4855',units, '01',units, '90',units, 0))                                                                        AS num_not_received ,
    SUM(DECODE(code,'41',units, 0))                                                                                                                                      AS num_cancel_recurring ,
    SUM(DECODE(code,'53',units, 0))                                                                                                                                      AS num_not_as_described ,
    SUM(DECODE(code,'60',units, '85',units, '86',units, 0))                                                                                                              AS num_no_credit ,
    SUM(DECODE(code,'56',units, 0))                                                                                                                                      AS num_defective ,
    SUM(DECODE(code,'34',units, '4534',units, '4348',units, '82',units, 0))                                                                                              AS num_duplicate ,
    SUM(DECODE(code,'35',units, '42',units, '71',units, '72',units, '73',units, '31',units, '80',units, '76',units, '07',units, '4507',units, '77',units, 0))            AS num_auth ,
    SUM(DECODE(code,'37',amount, '40',amount, '49',amount, '57',amount, '61',amount, '12',amount, '62',amount,'83',amount, '4837',amount, '4847',amount, 0))             AS amount_fraud ,
    SUM(DECODE(code,'54',amount, 'T',amount, 'RJ',amount, '08',amount, '4801',amount, 0))                                                                                AS amount_misc_cs ,
    SUM(DECODE(code,'63',amount, '75',amount, '4863',amount, 0))                                                                                                         AS amount_unrec ,
    SUM(DECODE(code,'30',amount, '55',amount, '59',amount, '4855',amount, '01',amount, '90',amount, 0))                                                                  AS amount_not_received ,
    SUM(DECODE(code,'41',amount, 0))                                                                                                                                     AS amount_cancel_recurring ,
    SUM(DECODE(code,'53',amount, 0))                                                                                                                                     AS amount_not_as_described ,
    SUM(DECODE(code,'60',amount, '85',amount, '86',amount, 0))                                                                                                           AS amount_no_credit ,
    SUM(DECODE(code,'56',amount, 0))                                                                                                                                     AS amount_defective ,
    SUM(DECODE(code,'34',amount, '4534',amount, '4348',amount, '82',amount, 0))                                                                                          AS amount_duplicate ,
    SUM(DECODE(code,'35',amount, '42',amount, '71',amount, '72',amount, '73',amount, '31',amount, '80',amount, '76',amount, '07',amount, '4507',amount, '77',amount, 0)) AS amount_auth
  FROM
    (SELECT division_id ,
      'Platform Total' division_site_id ,
      'null' code ,
      'sales' trans_type ,
      COUNT(cpg_transaction_id)units ,
      SUM(rpt.payment_amount/der.exchange_rate_num)amount
    FROM rcn_payment_transaction rpt,
      currency_exchange_sfact_vw der
    WHERE TRUNC(der.effective_date) = rpt.settlement_date
    AND rpt.TRANSACTION_CURRENCY    = der.to_currency_code
    AND transaction_type           IN ('Settle')
        and creation_date > &&date1
    AND settlement_date BETWEEN
      &&date1 AND
      &&date2
    AND division_id IN ('commerce5','element5','esellerate','pacific','regnow','swreg')
      --and  payment_method_id in ('MasterCard', 'Visa')
    AND status = 'Completed'
    GROUP BY division_id ,
      'platform total' ,
      'null' ,
      'sales'
    UNION ALL
    SELECT division_id ,
      'Platform Total' division_site_id ,
      reason_code ,
      'cbs' ,
      COUNT(cpg_transaction_id) units ,
      SUM(usd) amount
    FROM
      (SELECT rpt.CPG_TRANSACTION_ID ,
        rpt.division_order_id AS order_id ,
        rpt.division_site_id ,
        rpt.division_id ,
        rpt.payment_processor_name ,
        rpt.merchant_descriptor ,
        rpt.order_date ,
        extract(MONTH FROM rpt.order_date)
        || '-'
        || extract(YEAR FROM rpt.order_date) AS order_month ,
        rpt.settlement_date ,
        extract(MONTH FROM rpt.settlement_date)
        || '-'
        || extract(YEAR FROM rpt.settlement_date) cb_month ,
        rpt.transaction_type ,
        rpt.payment_method_id ,
        rpt.payment_amount                         AS amount ,
        (rpt.payment_amount/der.exchange_rate_num) AS usd ,
        rpt.transaction_currency                   AS currency ,
        rpt.status ,
        rpt.response_code AS reason_code ,
        DECODE(rpt.response_code, '1' , 'Non-Fraud','2' , 'Non-Fraud','4' , 'Non-Fraud','5' , 'Non-Fraud','6' , 'Non-Fraud','7' , 'Non-Fraud','8' , 'Non-Fraud','9' , 'Non-Fraud','10' , 'Non-Fraud','12' , 'Non-Fraud','13' , 'Non-Fraud','14' , 'Non-Fraud','22' , 'Fraud','28' , 'Non-Fraud','30' , 'Non-Fraud','31' , 'Non-Fraud','34' , 'Non-Fraud','35' , 'Non-Fraud','37' , 'Fraud','40' , 'Non-Fraud','41' , 'Non-Fraud','42' , 'Non-Fraud','45' , 'Non-Fraud','46' , 'Non-Fraud','47' , 'Non-Fraud','50' , 'Non-Fraud','53' , 'Non-Fraud','55' , 'Non-Fraud','59' , 'Non-Fraud','60' , 'Non-Fraud','62' , 'Non-Fraud','63' , 'Unrecognized','71' , 'Non-Fraud','72' , 'Non-Fraud','73' , 'Non-Fraud','74' , 'Non-Fraud','75' , 'Unrecognized','77' , 'Non-Fraud','80' , 'Non-Fraud','81' , 'Non-Fraud','82' , 'Non-Fraud','83' , 'Fraud','85' , 'Non-Fraud','86' , 'Non-Fraud','93' , 'Non-Fraud','98' , 'Non-Fraud','100' , 'Non-Fraud','1008' , 'Non-Fraud','1010' , 'Non-Fraud','4507' , 'Non-Fraud','4512' , 'Non-Fraud',
        '4516' , 'Non-Fraud','4517' , 'Non-Fraud','4544' , 'Non-Fraud','4554' , 'Non-Fraud','4753' , 'Non-Fraud','4801' , 'Non-Fraud','4808' , 'Non-Fraud','4834' , 'Non-Fraud','4835' , 'Non-Fraud','4837' , 'Fraud','4841' , 'Non-Fraud','4842' , 'Non-Fraud','4853' , 'Non-Fraud','4855' , 'Non-Fraud','4859' , 'Non-Fraud','4860' , 'Non-Fraud','4862' , 'Non-Fraud','4863' , 'Unrecognized','9050' , 'Non-Fraud','9051' , 'Non-Fraud','9052' , 'Non-Fraud','9053' , 'Non-Fraud','9055' , 'Non-Fraud','15 - CHRG BK PU' , 'Non-Fraud','16 - CHRG BK CR' , 'Non-Fraud','5 - SALE' , 'Non-Fraud','AP' , 'Non-Fraud','CR' , 'Non-Fraud','DA' , 'Non-Fraud','DP' , 'Non-Fraud','Fraud' , 'Fraud','Non-Fraud' , 'Non-Fraud','R10' , 'Non-Fraud','RJ' , 'Non-Fraud','RM' , 'Non-Fraud','RN2' , 'Non-Fraud','T' , 'Non-Fraud','T1106' , 'Fraud','T1201' , 'Fraud','U23' , 'Non-Fraud','U31' , 'Non-Fraud','U32' , 'Fraud','UA01' , 'Non-Fraud','UA02' , 'Non-Fraud','UA30' , 'Non-Fraud','UA31' , 'Non-Fraud','UA32' , 'Fraud',
        'Inquiry by PayPal' , 'Non-Fraud','Item not received' , 'Non-Fraud','Merchandise' , 'Non-Fraud','Non-receipt' , 'Non-Fraud','Unauthorized' , 'Fraud','Unauthorized payment' , 'Fraud','n/a' , 'Non-Fraud','other') AS CB_Reason ,
        rpt.usage_code ,
        rpt.bank_name ,
        rpt.recurring_flag ,
        rpt.customer_email ,
        rpt.customer_ip ,
        (SELECT SUM(rpt.payment_amount/der.exchange_rate_num)
        FROM rcn_payment_transaction
        WHERE transaction_type IN ('Settle')
        AND status              = 'Completed'
        AND division_order_id   = rpt.division_order_id
        AND rownum              < 2
        ) AS Settle_AMT ,
        (SELECT SUM(rpt.payment_amount/der.exchange_rate_num)
        FROM rcn_payment_transaction
        WHERE transaction_type IN ('ChargeBack')
        AND status              = 'Completed'
        AND division_order_id   = rpt.division_order_id
        AND rownum              < 2
        ) AS CB_AMT
      FROM rcn_payment_transaction rpt,
        currency_exchange_sfact_vw der
      WHERE TRUNC(der.effective_date) = rpt.settlement_date
      AND rpt.TRANSACTION_CURRENCY    = der.to_currency_code
      AND cpg_transaction_id         IN
        (SELECT
          /*junk.settlement_date, junk.division_order_id, junk.payment_amount , junk.division_id, */
          (
          SELECT cpg_transaction_id
          FROM rcn_payment_transaction
          WHERE transaction_type IN ('ChargeBack')
          AND division_order_id   = junk.division_order_id
          AND payment_amount      = junk.payment_amount
          AND rownum              < 2
          ) AS trans_id
        FROM
          ( SELECT DISTINCT
            (SELECT MIN(settlement_date)
            FROM rcn_payment_transaction
            WHERE transaction_type IN ('ChargeBack')
            AND division_order_id   = rpt.division_order_id
            )AS settlement_date,
            division_order_id,
            payment_amount,
            division_id,
            status
          FROM rcn_payment_transaction rpt
          WHERE division_order_id IN
            (SELECT division_order_id
            FROM rcn_payment_transaction
            WHERE transaction_type IN ('ChargeBack')
            AND response_code NOT  IN ('98', 'RJ', 'RV')
                and creation_date > &&date1
            AND settlement_date BETWEEN
              &&date1 AND
              &&date2
            AND division_id IN ('commerce5','element5','esellerate','pacific','regnow','swreg')
              --and     payment_method_id in ('MasterCard', 'Visa')
            AND (usage_code IS NULL
            OR usage_code    = '1')
            )
          AND transaction_type IN ('ChargeBack')
          AND status            = 'Completed'
          ORDER BY division_order_id,
            settlement_date
          ) junk
        WHERE settlement_date BETWEEN
          &&date1 AND
          &&date2
        )
      AND status = 'Completed'
      )
    GROUP BY division_id ,
      'platform total' ,
      reason_code ,
      'cbs'
    ) temp
  GROUP BY division_id ,
    division_site_id ,
    'Site_name'
  ) data1 ,
  (SELECT division_id ,
    COUNT(cpg_transaction_id) units ,
    SUM(usd) amount
  FROM
    (SELECT rpt.CPG_TRANSACTION_ID ,
      rpt.division_order_id AS order_id ,
      rpt.division_site_id ,
      rpt.division_id ,
      rpt.payment_processor_name ,
      rpt.merchant_descriptor ,
      rpt.order_date ,
      extract(MONTH FROM rpt.order_date)
      || '-'
      || extract(YEAR FROM rpt.order_date) AS order_month ,
      rpt.settlement_date ,
      extract(MONTH FROM rpt.settlement_date)
      || '-'
      || extract(YEAR FROM rpt.settlement_date) cb_month ,
      rpt.transaction_type ,
      rpt.payment_method_id ,
      rpt.payment_amount                         AS amount ,
      (rpt.payment_amount/der.exchange_rate_num) AS usd ,
      rpt.transaction_currency                   AS currency ,
      rpt.status ,
      rpt.response_code AS reason_code ,
      DECODE(rpt.response_code, '1' , 'Non-Fraud','2' , 'Non-Fraud','4' , 'Non-Fraud','5' , 'Non-Fraud','6' , 'Non-Fraud','7' , 'Non-Fraud','8' , 'Non-Fraud','9' , 'Non-Fraud','10' , 'Non-Fraud','12' , 'Non-Fraud','13' , 'Non-Fraud','14' , 'Non-Fraud','22' , 'Fraud','28' , 'Non-Fraud','30' , 'Non-Fraud','31' , 'Non-Fraud','34' , 'Non-Fraud','35' , 'Non-Fraud','37' , 'Fraud','40' , 'Non-Fraud','41' , 'Non-Fraud','42' , 'Non-Fraud','45' , 'Non-Fraud','46' , 'Non-Fraud','47' , 'Non-Fraud','50' , 'Non-Fraud','53' , 'Non-Fraud','55' , 'Non-Fraud','59' , 'Non-Fraud','60' , 'Non-Fraud','62' , 'Non-Fraud','63' , 'Unrecognized','71' , 'Non-Fraud','72' , 'Non-Fraud','73' , 'Non-Fraud','74' , 'Non-Fraud','75' , 'Unrecognized','77' , 'Non-Fraud','80' , 'Non-Fraud','81' , 'Non-Fraud','82' , 'Non-Fraud','83' , 'Fraud','85' , 'Non-Fraud','86' , 'Non-Fraud','93' , 'Non-Fraud','98' , 'Non-Fraud','100' , 'Non-Fraud','1008' , 'Non-Fraud','1010' , 'Non-Fraud','4507' , 'Non-Fraud','4512' , 'Non-Fraud',
      '4516' , 'Non-Fraud','4517' , 'Non-Fraud','4544' , 'Non-Fraud','4554' , 'Non-Fraud','4753' , 'Non-Fraud','4801' , 'Non-Fraud','4808' , 'Non-Fraud','4834' , 'Non-Fraud','4835' , 'Non-Fraud','4837' , 'Fraud','4841' , 'Non-Fraud','4842' , 'Non-Fraud','4853' , 'Non-Fraud','4855' , 'Non-Fraud','4859' , 'Non-Fraud','4860' , 'Non-Fraud','4862' , 'Non-Fraud','4863' , 'Unrecognized','9050' , 'Non-Fraud','9051' , 'Non-Fraud','9052' , 'Non-Fraud','9053' , 'Non-Fraud','9055' , 'Non-Fraud','15 - CHRG BK PU' , 'Non-Fraud','16 - CHRG BK CR' , 'Non-Fraud','5 - SALE' , 'Non-Fraud','AP' , 'Non-Fraud','CR' , 'Non-Fraud','DA' , 'Non-Fraud','DP' , 'Non-Fraud','Fraud' , 'Fraud','Non-Fraud' , 'Non-Fraud','R10' , 'Non-Fraud','RJ' , 'Non-Fraud','RM' , 'Non-Fraud','RN2' , 'Non-Fraud','T' , 'Non-Fraud','T1106' , 'Fraud','T1201' , 'Fraud','U23' , 'Non-Fraud','U31' , 'Non-Fraud','U32' , 'Fraud','UA01' , 'Non-Fraud','UA02' , 'Non-Fraud','UA30' , 'Non-Fraud','UA31' , 'Non-Fraud','UA32' , 'Fraud',
      'Inquiry by PayPal' , 'Non-Fraud','Item not received' , 'Non-Fraud','Merchandise' , 'Non-Fraud','Non-receipt' , 'Non-Fraud','Unauthorized' , 'Fraud','Unauthorized payment' , 'Fraud','n/a' , 'Non-Fraud','other') AS CB_Reason ,
      rpt.usage_code ,
      rpt.bank_name ,
      rpt.recurring_flag ,
      rpt.customer_email ,
      rpt.customer_ip ,
      (SELECT SUM(rpt.payment_amount/der.exchange_rate_num)
      FROM rcn_payment_transaction
      WHERE transaction_type IN ('Settle')
      AND status              = 'Completed'
      AND division_order_id   = rpt.division_order_id
      AND rownum              < 2
      ) AS Settle_AMT ,
      (SELECT SUM(rpt.payment_amount/der.exchange_rate_num)
      FROM rcn_payment_transaction
      WHERE transaction_type IN ('ChargeBack')
      AND status              = 'Completed'
      AND division_order_id   = rpt.division_order_id
      AND rownum              < 2
      ) AS CB_AMT
    FROM rcn_payment_transaction rpt,
      currency_exchange_sfact_vw der
    WHERE TRUNC(der.effective_date) = rpt.settlement_date
    AND rpt.TRANSACTION_CURRENCY    = der.to_currency_code
    AND cpg_transaction_id         IN
      (SELECT
        /*junk.settlement_date, junk.division_order_id, junk.payment_amount , junk.division_id, */
        (
        SELECT cpg_transaction_id
        FROM rcn_payment_transaction
        WHERE transaction_type IN ('ChargeBack')
        AND division_order_id   = junk.division_order_id
        AND payment_amount      = junk.payment_amount
        AND rownum              < 2
        ) AS trans_id
      FROM
        ( SELECT DISTINCT
          (SELECT MIN(settlement_date)
          FROM rcn_payment_transaction
          WHERE transaction_type IN ('ChargeBack')
          AND division_order_id   = rpt.division_order_id
          )AS settlement_date,
          division_order_id,
          payment_amount,
          division_id,
          status
        FROM rcn_payment_transaction rpt
        WHERE division_order_id IN
          (SELECT division_order_id
          FROM rcn_payment_transaction
          WHERE transaction_type IN ('ChargeBack')
          AND response_code NOT  IN ('98', 'RJ', 'RV')
              and creation_date > &&date1
          AND settlement_date BETWEEN
            &&date1 AND
            &&date2
          AND division_id IN ('commerce5','element5','esellerate','pacific','regnow','swreg')
            --and     payment_method_id in ('MasterCard', 'Visa')
          AND (usage_code IS NULL
          OR usage_code    = '1')
          )
        AND transaction_type IN ('ChargeBack')
        AND status            = 'Completed'
        ORDER BY division_order_id,
          settlement_date
        ) junk
      WHERE settlement_date BETWEEN
        &&date1 AND
        &&date2
      )
    AND status = 'Completed'
    )
  GROUP BY division_id
  )plat_data2 ,
  (SELECT COUNT(cpg_transaction_id) units ,
    SUM(usd) amount
  FROM
    (SELECT rpt.CPG_TRANSACTION_ID ,
      rpt.division_order_id AS order_id ,
      rpt.division_site_id ,
      rpt.division_id ,
      rpt.payment_processor_name ,
      rpt.merchant_descriptor ,
      rpt.order_date ,
      extract(MONTH FROM rpt.order_date)
      || '-'
      || extract(YEAR FROM rpt.order_date) AS order_month ,
      rpt.settlement_date ,
      extract(MONTH FROM rpt.settlement_date)
      || '-'
      || extract(YEAR FROM rpt.settlement_date) cb_month ,
      rpt.transaction_type ,
      rpt.payment_method_id ,
      rpt.payment_amount                         AS amount ,
      (rpt.payment_amount/der.exchange_rate_num) AS usd ,
      rpt.transaction_currency                   AS currency ,
      rpt.status ,
      rpt.response_code AS reason_code ,
      DECODE(rpt.response_code, '1' , 'Non-Fraud','2' , 'Non-Fraud','4' , 'Non-Fraud','5' , 'Non-Fraud','6' , 'Non-Fraud','7' , 'Non-Fraud','8' , 'Non-Fraud','9' , 'Non-Fraud','10' , 'Non-Fraud','12' , 'Non-Fraud','13' , 'Non-Fraud','14' , 'Non-Fraud','22' , 'Fraud','28' , 'Non-Fraud','30' , 'Non-Fraud','31' , 'Non-Fraud','34' , 'Non-Fraud','35' , 'Non-Fraud','37' , 'Fraud','40' , 'Non-Fraud','41' , 'Non-Fraud','42' , 'Non-Fraud','45' , 'Non-Fraud','46' , 'Non-Fraud','47' , 'Non-Fraud','50' , 'Non-Fraud','53' , 'Non-Fraud','55' , 'Non-Fraud','59' , 'Non-Fraud','60' , 'Non-Fraud','62' , 'Non-Fraud','63' , 'Unrecognized','71' , 'Non-Fraud','72' , 'Non-Fraud','73' , 'Non-Fraud','74' , 'Non-Fraud','75' , 'Unrecognized','77' , 'Non-Fraud','80' , 'Non-Fraud','81' , 'Non-Fraud','82' , 'Non-Fraud','83' , 'Fraud','85' , 'Non-Fraud','86' , 'Non-Fraud','93' , 'Non-Fraud','98' , 'Non-Fraud','100' , 'Non-Fraud','1008' , 'Non-Fraud','1010' , 'Non-Fraud','4507' , 'Non-Fraud','4512' , 'Non-Fraud',
      '4516' , 'Non-Fraud','4517' , 'Non-Fraud','4544' , 'Non-Fraud','4554' , 'Non-Fraud','4753' , 'Non-Fraud','4801' , 'Non-Fraud','4808' , 'Non-Fraud','4834' , 'Non-Fraud','4835' , 'Non-Fraud','4837' , 'Fraud','4841' , 'Non-Fraud','4842' , 'Non-Fraud','4853' , 'Non-Fraud','4855' , 'Non-Fraud','4859' , 'Non-Fraud','4860' , 'Non-Fraud','4862' , 'Non-Fraud','4863' , 'Unrecognized','9050' , 'Non-Fraud','9051' , 'Non-Fraud','9052' , 'Non-Fraud','9053' , 'Non-Fraud','9055' , 'Non-Fraud','15 - CHRG BK PU' , 'Non-Fraud','16 - CHRG BK CR' , 'Non-Fraud','5 - SALE' , 'Non-Fraud','AP' , 'Non-Fraud','CR' , 'Non-Fraud','DA' , 'Non-Fraud','DP' , 'Non-Fraud','Fraud' , 'Fraud','Non-Fraud' , 'Non-Fraud','R10' , 'Non-Fraud','RJ' , 'Non-Fraud','RM' , 'Non-Fraud','RN2' , 'Non-Fraud','T' , 'Non-Fraud','T1106' , 'Fraud','T1201' , 'Fraud','U23' , 'Non-Fraud','U31' , 'Non-Fraud','U32' , 'Fraud','UA01' , 'Non-Fraud','UA02' , 'Non-Fraud','UA30' , 'Non-Fraud','UA31' , 'Non-Fraud','UA32' , 'Fraud',
      'Inquiry by PayPal' , 'Non-Fraud','Item not received' , 'Non-Fraud','Merchandise' , 'Non-Fraud','Non-receipt' , 'Non-Fraud','Unauthorized' , 'Fraud','Unauthorized payment' , 'Fraud','n/a' , 'Non-Fraud','other') AS CB_Reason ,
      rpt.usage_code ,
      rpt.bank_name ,
      rpt.recurring_flag ,
      rpt.customer_email ,
      rpt.customer_ip ,
      (SELECT SUM(rpt.payment_amount/der.exchange_rate_num)
      FROM rcn_payment_transaction
      WHERE transaction_type IN ('Settle')
      AND status              = 'Completed'
      AND division_order_id   = rpt.division_order_id
      AND rownum              < 2
      ) AS Settle_AMT ,
      (SELECT SUM(rpt.payment_amount/der.exchange_rate_num)
      FROM rcn_payment_transaction
      WHERE transaction_type IN ('ChargeBack')
      AND status              = 'Completed'
      AND division_order_id   = rpt.division_order_id
      AND rownum              < 2
      ) AS CB_AMT
    FROM rcn_payment_transaction rpt,
      currency_exchange_sfact_vw der
    WHERE TRUNC(der.effective_date) = rpt.settlement_date
    AND rpt.TRANSACTION_CURRENCY    = der.to_currency_code
    AND cpg_transaction_id         IN
      (SELECT
        /*junk.settlement_date, junk.division_order_id, junk.payment_amount , junk.division_id, */
        (
        SELECT cpg_transaction_id
        FROM rcn_payment_transaction
        WHERE transaction_type IN ('ChargeBack')
        AND division_order_id   = junk.division_order_id
        AND payment_amount      = junk.payment_amount
        AND rownum              < 2
        ) AS trans_id
      FROM
        ( SELECT DISTINCT
          (SELECT MIN(settlement_date)
          FROM rcn_payment_transaction
          WHERE transaction_type IN ('ChargeBack')
          AND division_order_id   = rpt.division_order_id
          )AS settlement_date,
          division_order_id,
          payment_amount,
          division_id,
          status
        FROM rcn_payment_transaction rpt
        WHERE division_order_id IN
          (SELECT division_order_id
          FROM rcn_payment_transaction
          WHERE transaction_type IN ('ChargeBack')
          AND response_code NOT  IN ('98', 'RJ', 'RV')
              and creation_date > &&date1
          AND settlement_date BETWEEN
            &&date1 AND
            &&date2
          AND division_id IN ('commerce5','element5','esellerate','pacific','regnow','swreg')
            --and     payment_method_id in ('MasterCard', 'Visa')
          AND (usage_code IS NULL
          OR usage_code    = '1')
          )
        AND transaction_type IN ('ChargeBack')
        AND status            = 'Completed'
        ORDER BY division_order_id,
          settlement_date
        ) junk
      WHERE settlement_date BETWEEN
        &&date1 AND
        &&date2
      )
    AND status = 'Completed'
    )
  )global_data
WHERE plat_data2.division_id = data1.division_id
AND data1.cb_units          IS NOT NULL
ORDER BY division_id,
  cb_units DESC
