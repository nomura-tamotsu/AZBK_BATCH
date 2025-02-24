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
    TF_€iA.€iID
    ,TF_€iA.€iΌ
    ,TF_€iA.€iͺΜ
 FROM TF_€iA
;
COMMENT ON COLUMN TF_€i.€iID IS '';
COMMENT ON COLUMN TF_€i.€iΌ IS '';
COMMENT ON COLUMN TF_€i.€iͺΜ IS '';
EXIT;
