<?cs each:item = Page.Menu ?>
  <?cs name:item ?> - <a href="<?cs var:item.URL ?>">
        <?cs var:item.Name ?></a><br>
<?cs /each ?>