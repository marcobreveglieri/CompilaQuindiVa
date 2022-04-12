from delphivcl import *

class MainForm(Form):

    def __init__(self, owner):

        # Definisco le proprietà del Form
        self.Caption = "Cose da fare"
        self.SetBounds(100, 100, 700, 500)

        self.__sm = StyleManager()
        self.__sm.LoadFromFile("Glossy.vsf")
        self.__sm.SetStyle("Glossy")

        # Inizializzo i controlli
        self.__init_hint_label()
        self.__init_task_edit()
        self.__init_add_button()
        self.__init_task_listbox()
        self.__init_del_button()
        self.__init_clr_button()
        self.__init_exit_button()
        self.__init_action_list()

    def __init_action_list(self):
        # self.app_events = ApplicationEvents(self)
        # self.app_events.OnIdle = self.__task_actions_on_update
        self.task_actions = ActionList(self)
        self.del_action = Action(self)
        self.del_action.SetProps(Caption="Cancella")
        self.del_action.OnExecute=self.__del_button_on_click
        #self.del_button.Action=self.del_action
        self.task_actions.OnUpdate = self.__task_actions_on_update
        
    def __init_hint_label(self):
        self.hint_label = Label(self)
        self.hint_label.SetProps(
            AutoSize=True,
            Caption="Scrivi una nuova cosa da fare",
            Left=10,
            Parent=self,
            Top=10
        )

    def __init_task_edit(self):
        self.task_edit = Edit(self)
        self.task_edit.SetProps(Parent=self)
        self.task_edit.SetBounds(10, 30, 250, 20)

    def __init_add_button(self):
        self.add_button = Button(self)
        self.add_button.SetProps(Parent=self, Caption="&Aggiungi", Default=True)
        self.add_button.SetBounds(150, 75, 100, 30)
        self.add_button.OnClick = self.__add_button_on_click

    def __init_del_button(self):
        self.del_button = Button(self)
        self.del_button.SetProps(Parent=self, Caption="&Elimina")
        self.del_button.SetBounds(150, 120, 100, 30)
        self.del_button.OnClick = self.__del_button_on_click

    def __init_clr_button(self):
        self.clr_button = Button(self)
        self.clr_button.SetProps(Parent=self, Caption="&Pulisci")
        self.clr_button.SetBounds(150, 165, 100, 30)
        self.clr_button.OnClick = self.__clr_button_on_click

    def __init_exit_button(self):
        self.exit_button = Button(self)
        self.exit_button.SetProps(Parent=self, Caption="E&sci")
        self.exit_button.SetBounds(150, 300, 100, 30)
        self.exit_button.OnClick = self.__exit_button_on_click

    def __init_task_listbox(self):
        self.task_listbox = ListBox(self)
        self.task_listbox.SetProps(Parent=self)
        self.task_listbox.SetBounds(300, 50, 300, 350)

    def __task_actions_on_update(self, sender, handled):
        self.add_button.Enabled = len(self.task_edit.Text.trim()) > 0
        self.del_button.Enabled = self.task_listbox.ItemIndex >= 0
        self.clr_button.Enabled = self.task_listbox.Items.Count > 0
        handled = True

    def __add_button_on_click(self, sender):
        self.task_listbox.Items.Add(self.task_edit.Text)
        self.task_edit.Clear()

    def __del_button_on_click(self, sender):
        item_index = self.task_listbox.ItemIndex
        if (item_index < 0):
            return
        if (Application.MessageBox("Sei sicuro di voler cancellare l'attivita'?", "Eliminazione", MB_YESNO) != IDYES):
            return
        self.task_listbox.Items.Delete(item_index)

    def __clr_button_on_click(self, sender):
        if (Application.MessageBox("Sei sicuro di voler eliminare tutto?", "Pulizia", MB_YESNO) != IDYES):
            return
        self.task_listbox.Clear()

    def __exit_button_on_click(self, sender):
        self.Close()


def main():
    Application.Initialize()
    Application.Title = "Cose da fare"
    main_form = None
    #Application.CreateForm(MainForm, main_form)
    main_form = MainForm(Application)
    main_form.Show()
    #FreeConsole()
    Application.Run()
    main_form.Destroy()

main()
