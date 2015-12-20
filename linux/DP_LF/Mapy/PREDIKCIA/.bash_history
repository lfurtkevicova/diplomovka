v.in.ogr -o --overwrite input=/home/ludka/git/diplomovka/linux/DP_LF/data/zu.shp output=area min_area=0.0001 snap=-1 geometry=None
v.in.ogr -o input=/home/ludka/git/diplomovka/linux/DP_LF/data/geology.shp output=geology min_area=0.0001 snap=-1 geometry=None
v.in.ogr -o input=/home/ludka/git/diplomovka/linux/DP_LF/data/polohopis.shp output=polohopis min_area=0.0001 snap=-1 geometry=None
v.in.ogr -o input=/home/ludka/git/diplomovka/linux/DP_LF/data/vyskopis.shp output=vyskopis min_area=0.0001 snap=-1 geometry=None
v.in.ogr -o --overwrite input=/home/ludka/git/diplomovka/linux/DP_LF/data/zosuvy.shp output=zosuvy min_area=0.0001 snap=-1 geometry=None
g.region --overwrite vector=area res=1000
v.to.rast --overwrite input=area layer=1 type=point,line,area output=zu use=attr attribute_column=Id value=1 memory=300
v.to.rast --overwrite input=geology layer=1 type=point,line,area output=geology use=attr attribute_column=kat value=1 memory=300
v.to.rast --overwrite input=polohopis layer=1 type=point,line,area output=landuse use=attr attribute_column=Id value=1 memory=300
v.to.rast --overwrite input=zosuvy layer=1 type=point,line,area output=zosuvy0 use=attr attribute_column=Id value=1 memory=300
r.mapcalc --overwrite expression=zosuvy = if( zosuvy0 == 0, null(), 1)
r.mask --overwrite raster=zu maskcats=* layer=1
v.surf.rst --overwrite input=vyskopis layer=1 zcolumn=VYSKA elevation=dmr slope=slope aspect=aspect pcurvature=curvature_p_rst tcurvature=curvature_t_rst mcurvature=curvature_m tension=40. segmax=41 npmin=300 zscale=1.0
r.flow --overwrite elevation=dmr flowlength=flowlength
r.terraflow --overwrite elevation=dmr filled=filled direction=direction swatershed=swatershed accumulation=accumulation tci=tci memory=300
r.univar -g --overwrite map=geology output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/info/info_G.txt percentile=90 separator=pipe
r.univar -g --overwrite map=dmr output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/info/info_DMR.txt percentile=90 separator=pipe
r.univar -g --overwrite map=curvature_m output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/info/info_K.txt percentile=90 separator=pipe
r.univar -g --overwrite map=flowlength output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/info/info_DS.txt percentile=90 separator=pipe
r.univar -g --overwrite map=accumulation output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/info/info_M.txt percentile=90 separator=pipe
r.univar -g --overwrite map=landuse output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/info/info_VK.txt percentile=90 separator=pipe
r.univar -g --overwrite map=aspect output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/info/info_E.txt percentile=90 separator=pipe
r.univar -g --overwrite map=slope output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/info/info_S.txt percentile=90 separator=pipe
r.reclass --overwrite input=geology output=geology_recl1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl1/recl1_G.txt
r.recode --overwrite input=dmr output=dmr_recl1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl1/recl1_DMR.txt
r.recode --overwrite input=slope output=slope_recl1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl1/recl1_S.txt
r.recode --overwrite input=aspect output=aspect_recl1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl1/recl1_E.txt
r.reclass --overwrite input=landuse output=landuse_recl1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl1/recl1_VK.txt
r.recode --overwrite input=flowlength output=flowlength_recl1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl1/recl1_DS.txt
r.recode --overwrite input=accumulation output=accumulation_recl1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl1/recl1_M.txt
r.recode --overwrite input=curvature_m output=curv_m_recl1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl1/recl1_K.txt
r.report -h -n --overwrite map=geology_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_G.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=dmr_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_DMR.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=slope_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_S.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=aspect_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_E.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=landuse_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_VK.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=flowlength_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_DS.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=accumulation_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_M.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=curv_m_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_K.txt null_value=* page_length=0 page_width=79 nsteps=255
r.mask --overwrite raster=zosuvy0 maskcats=1 layer=1
r.report -h -n --overwrite map=geology_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_G_z.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=dmr_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_DMR_z.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=slope_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_S_z.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=aspect_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_E_z.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=landuse_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_VK_z.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=flowlength_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_DS_z.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=accumulation_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_M_z.txt null_value=* page_length=0 page_width=79 nsteps=255
r.report -h -n --overwrite map=curv_m_recl1 units=k,p output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/report/report_K_z.txt null_value=* page_length=0 page_width=79 nsteps=255
r.mask --overwrite raster=zu maskcats=* layer=1
r.reclass --overwrite input=geology output=geology_recl2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl2/recl2_G.txt
r.reclass --overwrite input=dmr_recl1 output=dmr_recl2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl2/recl2_DMR.txt
r.reclass --overwrite input=slope_recl1 output=slope_recl2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl2/recl2_S.txt
r.reclass --overwrite input=aspect_recl1 output=aspect_recl2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl2/recl2_E.txt
r.reclass --overwrite input=landuse_recl1 output=landuse_recl2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl2/recl2_VK.txt
r.reclass --overwrite input=flowlength_recl1 output=flowlength_recl2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl2/recl2_DS.txt
r.reclass --overwrite input=accumulation_recl1 output=accumulation_recl2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl2/recl2_M.txt
r.reclass --overwrite input=curv_m_recl1 output=curv_m_recl2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl2/recl2_K.txt
r.mapcalc --overwrite file=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/rovnica.txt
r.univar -g --overwrite map=y output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/info_y.txt percentile=90 separator=pipe
g.region -p raster=y
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png compression=1
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=480 resolution=0 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p raster=y,zu@PREDIKCIA
r.colors -e map=y,zu@PREDIKCIA color=gyr
r.recode --overwrite input=y,zu@PREDIKCIA output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.out.png -t --overwrite input=y,zu@PREDIKCIA output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png compression=1
r.recode --overwrite input=y,zu@PREDIKCIA output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y,zu@PREDIKCIA output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y,zu@PREDIKCIA output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=480 resolution=0 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y,zu@PREDIKCIA bgcolor=white
d.mon -r bgcolor=white
g.region -p raster=y
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png compression=1
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=480 resolution=0 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.out.png -t --overwrite input=y output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png compression=1
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=480 resolution=0 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
r.stats
r.info map=y@PREDIKCIA
g.region -p --overwrite raster=y
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=639 height=478 resolution=0 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=639 height=478 resolution=0 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=639 height=478 resolution=10 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=639 height=478 resolution=1000 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=639 height=478 resolution=0 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=0 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
r.stats
r.stats input=y_COV3@PREDIKCIA,zosuvy0@PREDIKCIA
r.stats -n input=y_COV3@PREDIKCIA,zosuvy0@PREDIKCIA
r.stats -n input=zosuvy0@PREDIKCIA,y_COV1@PREDIKCIA
r.stats input=zosuvy0@PREDIKCIA,y_COV1@PREDIKCIA
r.stats input=zosuvy0@PREDIKCIA,y_COV2@PREDIKCIA
r.stats input=zosuvy0@PREDIKCIA,y_COV3@PREDIKCIA
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=0 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=0 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=zu res=10
r.colors -e map=zu color=gyr
r.recode --overwrite input=zu output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=zu output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=zu output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=zu output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=0 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=zu bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=0 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.gisenv -n
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast --verbose map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast --verbose map=y bgcolor=white
d.rast map=cccccc bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y@PREDIKCIA res=10
r.colors -e map=y@PREDIKCIA color=gyr
r.recode --overwrite input=y@PREDIKCIA output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y@PREDIKCIA output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y@PREDIKCIA output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y@PREDIKCIA output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast --verbose map=y@PREDIKCIA bgcolor=white
d.rast map=cccccc bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast --verbose map=y bgcolor=white
d.rast map=cccccc bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=wx0 width=640 height=478 resolution=1 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=wx1 width=640 height=478 resolution=3 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=wx0 width=640 height=478 resolution=3 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=wx0 width=640 height=478 resolution=3 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=3 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region raster=y@PREDIKCIA res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=3 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y@PREDIKCIA res=10
r.colors -e map=y@PREDIKCIA color=gyr
r.recode --overwrite input=y@PREDIKCIA output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y@PREDIKCIA output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y@PREDIKCIA output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y@PREDIKCIA output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=wx0 width=640 height=478 resolution=3 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y@PREDIKCIA bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y@PREDIKCIA res=10
r.colors -e map=y@PREDIKCIA color=gyr
r.recode --overwrite input=y@PREDIKCIA output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y@PREDIKCIA output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y@PREDIKCIA output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y@PREDIKCIA output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=wx0 width=640 height=478 resolution=3 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y@PREDIKCIA bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=3 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.out.png --overwrite input=y@PREDIKCIA output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png compression=6
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=3 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=wx0 width=640 height=478 resolution=3 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=478 resolution=3 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
g.region -p --overwrite raster=y res=10
r.colors -e map=y color=gyr
r.recode --overwrite input=y output=ba rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_y.txt title=kategorie
r.recode --overwrite input=y output=y_COV1 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV1.txt title=validation
r.stats -a -n --overwrite input=y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet//y_stats_COV1.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV1 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV1.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV2 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV2.txt
r.stats -a -n --overwrite --quiet input=y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV2.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV2 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV2.txt separator=space null_value=* nsteps=255
r.recode --overwrite input=y output=y_COV3 rules=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/recl_COV3.txt
r.stats -a -n --overwrite input=y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y_stats_COV3.txt separator=space null_value=* nsteps=255
r.stats -c -n --overwrite input=zosuvy0,y_COV3 output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/stats_COV3.txt separator=space null_value=* nsteps=255
r.category map=ba separator=: rules=/home/ludka/git/diplomovka/linux/DP_LF/nastroj/files/display/cat_vysledok.txt
d.mon --overwrite start=cairo width=640 height=470 resolution=3 bgcolor=white output=/home/ludka/git/diplomovka/linux/DP_LF/vypocet/y.png
d.rast map=y bgcolor=white
d.mon -r bgcolor=white
r.info map=y@PREDIKCIA
r.unpack
exit
r.pack
r.unpack
r.unpack input=/home/ludka/y.pack output=ypack
