<?php
/**
 * AppShell file
 *
 * @link          https://cakephp.org CakePHP(tm) Project
 * @since         CakePHP(tm) v 2.0
 */

App::uses('Shell', 'Console');
App::uses('Note', 'Model');
App::uses('User', 'Model');

/**
 * Application Shell
 *
 * Add your application-wide methods in the class below, your shells
 * will inherit them.
 *
 * @package       app.Console.Command
 */
class AppShell extends Shell
{
    public User $User;
    public Note $Note;
    public Faker\Provider\Person $Person;

    public function __construct($stdout = null, $stderr = null, $stdin = null)
    {
        parent::__construct($stdout, $stderr, $stdin);

        $this->Note = new Note();
        $this->User = new User();

        $this->Person = new Faker\Provider\en_GB\Person(
            new \Faker\Generator()
        );
    }

    public function repl()
    {
        eval(\Psy\sh());
    }

    public function newUser()
    {
        $this->User->create();
        $this->User->save([
            'first_name' => $this->Person->firstName(
                Faker\Provider\Miscellaneous::boolean()
                    ? \Faker\Provider\Person::GENDER_MALE
                    : \Faker\Provider\Person::GENDER_FEMALE
            ),
            'last_name'  => $this->Person->lastName(),
        ]);

        pr($this->User->find('first', [
            'conditions' => [
                'User.id' => $this->User->getLastInsertID(),
            ]
        ]));
    }

    public function newNote()
    {
        // Pick a random user
        $user_id = $this->User->field(
            'id',
            null,
            'rand()'
        );

        $this->Note->create();
        $this->Note->save([
            'content' => Faker\Provider\Lorem::words(rand(10,20), true),
            'user_id' => $user_id,
        ]);

        pr($this->Note->find('first', [
            'conditions' => [
                'Note.id' => $this->Note->getLastInsertID(),
            ]
        ]));
    }

    public function listNotes()
    {
        // Works!
//        $data = $this->Note->find('all', [
//            'contain' => [
//                'User',
//            ]
//        ]);

        $data = $this->Note->find('all', [
           'joins' => [
               [
                   'table' => $this->User->getDataSource()->config['database'] . '.users',
                   'alias' => 'User',
                   'type'  => 'INNER',
                   'conditions' => [
                       'User.id = Note.user_id',
                   ]
               ]
           ]
        ]);

        dd($data);

        // $this->helper('table')->output($data);
    }
}
