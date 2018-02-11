import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';

import {BrowserAnimationsModule} from '@angular/platform-browser/animations';
import {NoopAnimationsModule} from '@angular/platform-browser/animations';

import {MatButtonModule, MatCheckboxModule} from '@angular/material';

import { AppComponent } from './app.component';
import { DialogResultExampleComponent } from './dialog-result-example/dialog-result-example.component';


@NgModule({
  declarations: [
    AppComponent,
    DialogResultExampleComponent
  ],
  imports: [
    BrowserModule,
    BrowserAnimationsModule,
    NoopAnimationsModule,
    MatButtonModule,
    MatCheckboxModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
