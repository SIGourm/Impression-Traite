report 50105 "Impression Traite"
{
    UsageCategory = Administration;
    ApplicationArea = All;

    // Use an RDL layout.
    DefaultLayout = RDLC;

    // Specify the name of the file that the report will use for the layout.
    RDLCLayout = 'ImpressionTraite.rdl';



    dataset
    {
        dataitem("Payment Header"; "Payment Header")
        {
            DataItemTableView = sorting("No.");


            RequestFilterFields = "No.";


            column(No; "No.")
            {
                // Include the caption of the "No." field in the dataset of the report.
                IncludeCaption = true;

            }



            dataitem("Payment Line"; "Payment Line")
            {
                DataItemLink = "No." = field("No.");

                DataItemLinkReference = "Payment Header";


                column(No_; "No.")
                {
                    // Include the caption of the "No." field in the dataset of the report.
                    IncludeCaption = true;

                }
                column(Posting_Date; "Posting Date")
                {
                    // Include the caption of the "No." field in the dataset of the report.
                    IncludeCaption = true;

                }
                column(Due_Date; "Due Date")
                {
                    // Include the caption of the "No." field in the dataset of the report.
                    IncludeCaption = true;

                }
                column(Currency_Code; "Currency Code")
                {
                    // Include the caption of the "No." field in the dataset of the report.
                    IncludeCaption = true;

                }

                column(Frs; "No.")
                {

                }
                column(TxtBranchNo; "TxtBranchNo")
                {

                }
                column(TxtAccount1; "TxtAccount1")
                {

                }
                column(TxtAccount2; "TxtAccount2")
                {

                }
                column(TxtAccount3; "TxtAccount3")
                {

                }
                column(TxtAccount4; "TxtAccount4")
                {

                }
                column(TxtAccount5; "TxtAccount5")
                {

                }
                column(CompanyInfo; "City")
                {

                }
                column(RIB; "RIB")
                {

                }
                column(BankInfo; "BankInfo")
                {

                }
                column(BankInfo2; "BankInfo2")
                {

                }
                column(MntTTlettre; "MntTTlettre")
                {

                }



                trigger OnAfterGetRecord()

                begin

                    Frs.GET("Account No.");
                    CompBank.RESET;

                    TOT := TOT + "Payment Line"."Debit Amount";

                    MntTTlettre := '';
                    //Convert."Montant en texte"(MntTTlettre,ABS(Amount));

                    CompBank.RESET;
                    //CompBank.SETRANGE("No.", "Payment Line"."Header Account No.");
                    IF NOT CompBank.FIND('-') THEN
                        CompBank.SETRANGE("No.", CompanyInfo."Default Bank Account No.");
                    IF CompBank.FIND('-') THEN;
                    BEGIN
                        BankInfo := CompBank.Name + ' ' + CompBank."Name 2" + ' ' + CompBank.Address + ' ' + CompBank."Address 2"
                                    + ' ' + CompBank.City;


                    END;


                end;



            }
            trigger OnAfterGetRecord()
            begin


                CompanyInfo.GET;
                IF "Payment Header"."Currency Code" = '' THEN
                    Devise := 'EUR'
                ELSE
                    Devise := "Currency Code";
                City := "Bank City";

                TxtBranchNo := "Bank Branch No.";
                TxtAcencyCode := COPYSTR("Agency Code", 1, 3);

                TxtAccount1 := COPYSTR("Bank Account No.", 1, 4);
                TxtAccount2 := COPYSTR("Bank Account No.", 5, 3);
                TxtAccount3 := COPYSTR("Bank Account No.", 8, 5);
                TxtAccount4 := COPYSTR("Bank Account No.", 13, 1);
                TxtAccount5 := COPYSTR("Bank Account No.", 14, 2);

                "TxtAccount_No" := "Bank Account No.";
                RIB := FORMAT("RIB Key");
                IF STRLEN(RIB) < 2 THEN
                    RIB := RIB;


                BankInfo := "Source Code";

            end;
        }


    }



    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    // field(Name; SourceExpression)
                    // {
                    // ApplicationArea = All;

                    //}
                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }



    var



        NBank: Text[30];
        Etab: Text[30];
        Cagence: Text[30];
        CompanyAddr: Text[50];
        BankInfo: Text[250];
        BankInfo2: Text[250];
        RIB: Text[30];
        TxtBranchNo: Text[30];
        TxtAcencyCode: Text[30];
        TxtAccount_No: Text[30];
        City: Text[30];
        MntTTlettre: Text[250];
        TxtAccount1: Text[30];
        TxtAccount2: Text[30];
        TxtAccount3: Text[30];
        TxtAccount4: Text[30];
        TxtAccount5: Text[30];
        Info_gt: Text[80];
        NomBq: Text[30];

        CompanyInfo: Record "Company Information";
        CompBank: Record "Bank Account";
        BankAccount_gr: Record "Bank Account";
        Frs: Record "Vendor";
        Bank: Record "Vendor Bank Account";

        Compteur: Integer;
        RIBKEY: Integer;
        Res: Integer;
        Compte: Integer;
        Nligne: Integer;


        TOT: Decimal;

        Devise: Code[10];

}