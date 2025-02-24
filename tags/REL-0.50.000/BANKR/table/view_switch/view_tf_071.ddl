--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_ÂÊ¾×MûÀ                                           */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_ÂÊ¾×MûÀ
    (XÔ
    ,CIFNO
    ,¢ÑÔ
    ,ÂléÆÔ
    ,ûÀÔ
    ,SÒR[h
    ,SÒ¼Ji
    ,SÒ¼
    ,Î±æ
    ,ðE¼
    ,UâsID
    ,UxXID
    ,ÈÚID
    ,UûÀ
    ,ÀÝz
    ,\gÀxz
    ,pàz
    ,]Tg
    ,ûÀJÝNú
    ,c
    ,ûÀæª
    ,æ·Döcàz
    ,KpI¹ú
    ,f[^îú
    )
 AS SELECT 
    TF_ÂÊ¾×MûÀA.XÔ
    ,TF_ÂÊ¾×MûÀA.CIFNO
    ,TF_ÂÊ¾×MûÀA.¢ÑÔ
    ,TF_ÂÊ¾×MûÀA.ÂléÆÔ
    ,TF_ÂÊ¾×MûÀA.ûÀÔ
    ,TF_ÂÊ¾×MûÀA.SÒR[h
    ,TF_ÂÊ¾×MûÀA.SÒ¼Ji
    ,TF_ÂÊ¾×MûÀA.SÒ¼
    ,TF_ÂÊ¾×MûÀA.Î±æ
    ,TF_ÂÊ¾×MûÀA.ðE¼
    ,TF_ÂÊ¾×MûÀA.UâsID
    ,TF_ÂÊ¾×MûÀA.UxXID
    ,TF_ÂÊ¾×MûÀA.ÈÚID
    ,TF_ÂÊ¾×MûÀA.UûÀ
    ,TF_ÂÊ¾×MûÀA.ÀÝz
    ,TF_ÂÊ¾×MûÀA.\gÀxz
    ,TF_ÂÊ¾×MûÀA.pàz
    ,TF_ÂÊ¾×MûÀA.]Tg
    ,TF_ÂÊ¾×MûÀA.ûÀJÝNú
    ,TF_ÂÊ¾×MûÀA.c
    ,TF_ÂÊ¾×MûÀA.ûÀæª
    ,TF_ÂÊ¾×MûÀA.æ·Döcàz
    ,TF_ÂÊ¾×MûÀA.KpI¹ú
    ,TF_ÂÊ¾×MûÀA.f[^îú
 FROM TF_ÂÊ¾×MûÀA
;
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.XÔ IS 'TM_cÆX.XÔðQÆB';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.CIFNO IS '';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.¢ÑÔ IS 'LøViÅè·j';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.ÂléÆÔ IS '';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.ûÀÔ IS 'iCIFNOj';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.SÒR[h IS 'æµSÒR[hB';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.SÒ¼Ji IS 'æµSÒ¼JiB';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.SÒ¼ IS 'æµSÒ¼¿B';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.Î±æ IS 'Î±æ¼ÌiSpj';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.ðE¼ IS 'Sp';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.UâsID IS 'UâsR[h';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.UxXID IS 'UxXR[h';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.ÈÚID IS '1:ÊA2:ÀA4:~aàA9:»Ì¼';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.UûÀ IS 'UûÀ';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.ÀÝz IS 'øûÀiCIFR[h25j';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.\gÀxz IS '}D\gÀxzB~PÊ ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.pàz IS '}DÌónpàz+ÝpàzB~PÊ ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.]Tg IS '}DÌiónÀxz+ÝÀxz)-(ónpàz+ÝpàzjB~PÊ ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.ûÀJÝNú IS '';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.c IS 'ævàz ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.ûÀæª IS '0F¢o^iêÊûÀj@1F¹ò¥û@2Fmè\';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.æ·Döcàz IS '';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.KpI¹ú IS '';
COMMENT ON COLUMN TF_ÂÊ¾×MûÀ.f[^îú IS '';
EXIT;
