--/*==========================================================================*/
--/* COPYRIGHT Information Services International-Dentsu, Ltd.                */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANKER R^NgZ^[                                    */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_ΒΚΎΧΕθ«aΰ                                         */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | 15/01/22 | y NκY | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_ΒΚΎΧΕθ«aΰ
    (XΤ
    ,CIFNO
    ,’ΡΤ
    ,ΒlιΖΤ
    ,ΘΪID
    ,ϋΐΤ
    ,ϋΐϋΤ
    ,}Τ
    ,€iID
    ,aόϊ
    ,ΕζͺID
    ,ΰz
    ,¦
    ,ϊϊ
    ,ϋΐc
    ,ζ΅XΫ
    ,ϋΐJέNϊ
    ,ΚΨζͺID
    ,aόϊΤ
    ,ΟCID
    ,ϊ\ρTC
    ,Είζψϊ
    ,f[^ξϊ
    ,dgaΰ
    )
 AS SELECT
    TF_ΒΚΎΧΕθ«aΰB.XΤ
    ,TF_ΒΚΎΧΕθ«aΰB.CIFNO
    ,TF_ΒΚΎΧΕθ«aΰB.’ΡΤ
    ,TF_ΒΚΎΧΕθ«aΰB.ΒlιΖΤ
    ,TF_ΒΚΎΧΕθ«aΰB.ΘΪID
    ,TF_ΒΚΎΧΕθ«aΰB.ϋΐΤ
    ,TF_ΒΚΎΧΕθ«aΰB.ϋΐϋΤ
    ,TF_ΒΚΎΧΕθ«aΰB.}Τ
    ,TF_ΒΚΎΧΕθ«aΰB.€iID
    ,TF_ΒΚΎΧΕθ«aΰB.aόϊ
    ,TF_ΒΚΎΧΕθ«aΰB.ΕζͺID
    ,TF_ΒΚΎΧΕθ«aΰB.ΰz
    ,TF_ΒΚΎΧΕθ«aΰB.¦
    ,TF_ΒΚΎΧΕθ«aΰB.ϊϊ
    ,TF_ΒΚΎΧΕθ«aΰB.ϋΐc
    ,TF_ΒΚΎΧΕθ«aΰB.ζ΅XΫ
    ,TF_ΒΚΎΧΕθ«aΰB.ϋΐJέNϊ
    ,TF_ΒΚΎΧΕθ«aΰB.ΚΨζͺID
    ,TF_ΒΚΎΧΕθ«aΰB.aόϊΤ
    ,TF_ΒΚΎΧΕθ«aΰB.ΟCID
    ,TF_ΒΚΎΧΕθ«aΰB.ϊ\ρTC
    ,TF_ΒΚΎΧΕθ«aΰB.Είζψϊ
    ,TF_ΒΚΎΧΕθ«aΰB.f[^ξϊ
    ,TF_ΒΚΎΧΕθ«aΰB.dgaΰ
 FROM TF_ΒΚΎΧΕθ«aΰB
;
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.XΤ IS 'TM_cΖX.XΤπQΖB';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.CIFNO IS 'Lψ10iΕθ·j';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.’ΡΤ IS 'Lψ10iΕθ·j';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ΒlιΖΤ IS 'ΒlιΖΤF"99999999999"Εθ@y’gpz';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ΘΪID IS '4Εθi0pfBOjAΆlBΘΪi2j{aΰνήi2j';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ϋΐΤ IS 'VΕθ';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ϋΐϋΤ IS 'y’gpz';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.}Τ IS '7Εθi0pfBOj';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.€iID IS 'TF_€i.€iIDπQΖB6Εθi0pfBOj';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.aόϊ IS 'ΌοYYYYMMDD';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ΕζͺID IS 'TM_Εζͺ.ΕζͺIDπQΖB';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ΰz IS '';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.¦ IS '';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ϊϊ IS 'ΌοYYYYMMDD';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ϋΐc IS 'Εθl0';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ζ΅XΫ IS 'X(3Εθ)+(2Εθ)+Ϋ(2Εθ)';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ϋΐJέNϊ IS 'ΌοYYYYMMDD';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ΚΨζͺID IS 'TM_ΚΨζͺ.ΚΨͺIDπQΖB';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.aόϊΤ IS 'PΚi999.9j';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ΟCID IS 'TM_ΟCR[h.ΟCIDπQΖ';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.ϊ\ρTC IS '0F\ρo^Θ΅A1F\ρo^ΟέBf[^ͺΘ’κΝA1BytesΜΌpXy[XB';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.Είζψϊ IS 'ΌοYYYYMMDD';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.f[^ξϊ IS 'ΌοYYYYMMDD';
COMMENT ON COLUMN TF_ΒΚΎΧΕθ«aΰ.dgaΰ IS '1Fdgaΰ 0F»κΘO';
EXIT;
