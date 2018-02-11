import {Component} from '@angular/core';
import {MatDialog, MatDialogRef} from '@angular/material';



@Component({
  selector: 'app-dialog-result-example-dialog',
  templateUrl: 'dialog-result-example-dialog.html',
})
export class DialogResultExampleDialogComponent {
  constructor(public dialogRef: MatDialogRef<DialogResultExampleDialogComponent>) {}
}


@Component({
  selector: 'app-dialog-result-example',
  templateUrl: './dialog-result-example.component.html',
})
export class DialogResultExampleComponent {
  selectedOption: string;

  constructor(public dialog: MatDialog) {}

  openDialog() {
    const dialogRef = this.dialog.open(DialogResultExampleDialogComponent);
    dialogRef.afterClosed().subscribe(result => {
      this.selectedOption = result;
    });
  }
}

