--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TMB_Sâ                                                      */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TMB_Sâ
    (âsÔ
    ,âs¼¿
    ,âs¼Ji
    ,ÆÔID
    ,âsKpJnNú
    ,âsKpI¹Nú
    ,XÔ
    ,X¼¿
    ,X¼Ji
    ,xXKpJnNú
    ,xXKpI¹Nú
    ,o^ú
    ,o^Ò
    )
 AS SELECT 
    TMB_âsB.âsÔ
    ,TMB_âsB.âs¼¿
    ,TMB_âsB.âs¼Ji
    ,TMB_âsB.ÆÔID
    ,TMB_âsB.KpJnNú
    ,TMB_âsB.KpI¹Nú
    ,TMB_xXB.XÔ
    ,TMB_xXB.X¼¿
    ,TMB_xXB.X¼Ji
    ,TMB_xXB.KpJnNú
    ,TMB_xXB.KpI¹Nú
    ,TMB_xXB.o^ú
    ,TMB_xXB.o^Ò
 FROM TMB_âsB,TMB_xXB
 WHERE TMB_âsB.âsÔ=TMB_xXB.âsÔ;

COMMENT ON COLUMN TMB_Sâ.âsÔ IS 'TMB_ÆÔ.ÆÔR[hðQÆB';
COMMENT ON COLUMN TMB_Sâ.âs¼¿ IS '';
COMMENT ON COLUMN TMB_Sâ.âs¼Ji IS '';
COMMENT ON COLUMN TMB_Sâ.ÆÔID IS 'TMB_âsÆÔ.ÆÔIDðQÆB';
COMMENT ON COLUMN TMB_Sâ.âsKpJnNú IS '';
COMMENT ON COLUMN TMB_Sâ.âsKpI¹Nú IS '';
COMMENT ON COLUMN TMB_Sâ.XÔ IS '';
COMMENT ON COLUMN TMB_Sâ.X¼¿ IS '';
COMMENT ON COLUMN TMB_Sâ.X¼Ji IS '';
COMMENT ON COLUMN TMB_Sâ.xXKpJnNú IS '';
COMMENT ON COLUMN TMB_Sâ.xXKpI¹Nú IS '';
COMMENT ON COLUMN TMB_Sâ.o^ú IS '';
COMMENT ON COLUMN TMB_Sâ.o^Ò IS '';
EXIT;
