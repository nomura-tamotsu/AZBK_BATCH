--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_€i                                                       */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_€i
    (€iID
    ,€iΌ
    ,€iͺΜ
    )
 AS SELECT 
    TF_€iB.€iID
    ,TF_€iB.€iΌ
    ,TF_€iB.€iͺΜ
 FROM TF_€iB
;
COMMENT ON COLUMN TF_€i.€iID IS '€iID6Εθ';
COMMENT ON COLUMN TF_€i.€iΌ IS 'κ\¦gp';
COMMENT ON COLUMN TF_€i.€iͺΜ IS 'BANKERob`ΕSpXy[X2Bytesπέθ';
EXIT;
