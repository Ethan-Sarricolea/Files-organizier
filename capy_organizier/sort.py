"""
Description: window to improve code interaction for users
Author: Ethan Sarricolea
"""

import subprocess
from tkinter import END, messagebox,Tk,Entry,Label,Button,font,filedialog,Frame

class App:
    def __init__(self):
        self.root = Tk()
        self.root.geometry("500x250")
        self.root.title("Organizier")
        self.root.resizable(0,0)
        self.root.iconbitmap("capy_organizier\\folders.ico")

    def execute(self, arg1):
        dartPath = r"bin\sorting.dart"
        command = f'dart {dartPath} "{arg1}"'
        if arg1=="":
            messagebox.showwarning("Capy organizier","Please make sure to enter the route")
        else:
            try:
                subprocess.run(command, check=True)
                self.msj.place(x=200,y=210)
                self.root.after(5000, self.msj.place_forget)
            except subprocess.CalledProcessError as e:
                messagebox.showerror("Capy organizier",
                                    f"An execution error occurred: {e}")
                print(e)

    def select_dir(self):
        ruta = str(filedialog.askdirectory())
        self.userInput.delete(0,END)
        self.userInput.insert("end", ruta)

    def start(self):
        argument = messagebox.askokcancel("Capy organizier",
                            "Are you sure about organizing on the route?")
        if argument:
            self.execute(self.userInput.get())

    def run(self):
        Frame(self.root,bg="DodgerBlue3",width=500,height=50).place(x=0,y=0)
        Label(self.root,
            font=font.Font(size=25),
            bg="DodgerBlue3",
            foreground="snow",
            text="Capy Organizier").pack(anchor="center")
        Label(self.root,
            font=font.Font(size=10),
            text="Select the path of the folder you want to organize").place(x=60,y=60)
        self.userInput = Entry(self.root,width=50)
        self.userInput.place(x=50,y=100)
        Button(self.root,
            text="Search path",
            command=(self.select_dir)).place(x=380,y=98)
        Button(self.root,
            text="Continue",
            width=10,
            bg="springGreen2",
            command=self.start).place(x=80,y=150)
        Button(self.root,
            text="Quit",
            bg="light coral",
            width=10,
            command=self.root.quit).place(x=200,y=150)
        self.msj = Label(self.root,text="Organization finished")
        self.root.mainloop()