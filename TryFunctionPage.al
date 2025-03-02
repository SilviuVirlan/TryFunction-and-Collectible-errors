// This page demonstrates the TryFunction example

page 70302 "Try Function Demo Page"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    Caption = 'Try Function Demo';

    layout
    {
        area(Content)
        {
            group(Information)
            {
                Caption = 'TryFunction Example';

                label(Description)
                {
                    Caption = 'This page demonstrates the use of TryFunction in AL.';
                    ApplicationArea = All;
                }

                label(Instructions)
                {
                    Caption = 'Click the "Run Example" action to see TryFunction in action.';
                    ApplicationArea = All;
                }

                label(Explanation)
                {
                    Caption = 'TryFunction allows you to handle errors without causing the entire process to fail.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RunExample1)
            {
                ApplicationArea = All;
                Caption = 'Run Example 1';
                Image = ExecuteBatch;
                ToolTip = 'Run the TryFunction example';

                trigger OnAction()
                begin
                    TryGetDataWithErrorCollect('aaa', 'bbb');
                end;
            }

            action(RunExample2)
            {
                ApplicationArea = All;
                Caption = 'Run Example 2';
                Image = ExecuteBatch;
                ToolTip = 'Run the TryFunction example';

                trigger OnAction()
                begin
                    TryGetDataWithErrorCollect('10000', 'bbb');
                end;
            }
            action(RunExample3)
            {
                ApplicationArea = All;
                Caption = 'Run Example 3';
                Image = ExecuteBatch;
                ToolTip = 'Run the TryFunction example';

                trigger OnAction()
                begin
                    TryGetDataWithErrorCollect('aaa', '10000');
                end;
            }
            action(RunExample4)
            {
                ApplicationArea = All;
                Caption = 'Run Example 4';
                Image = ExecuteBatch;
                ToolTip = 'Run the TryFunction example';

                trigger OnAction()
                begin
                    TryGetDataWithErrorCollect('10000', '10000');
                end;
            }
        }
    }

    [ErrorBehavior(ErrorBehavior::Collect)]
    local procedure TryGetDataWithErrorCollect(arg1: Text; arg2: Text)
    var
        errors: Record "Error Message" temporary;
        TryFunctionExample: Codeunit "Try Function Example 2";
        error: ErrorInfo;
    begin
        if not TryFunctionExample.TryGetMasterData(arg1, arg2) then begin
            errors.ID := errors.ID + 1;
            errors.Message := GetLastErrorText();
            errors.Insert();
        end;
        if HasCollectedErrors then
            foreach error in system.GetCollectedErrors() do begin
                errors.ID := errors.ID + 1;
                errors.Message := error.Message;
                errors.Validate("Record ID", error.RecordId);
                errors.Insert();
            end;
        ClearCollectedErrors();
        if errors.Count() > 0 then
            page.RunModal(page::"Error Messages", errors)
        else
            Message('No errors encountered during the TryFunction execution.');
    end;
}
