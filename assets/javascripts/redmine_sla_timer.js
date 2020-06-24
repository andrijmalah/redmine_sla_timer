setInterval(function(){ 
update_sla_timers();
}, 30000);

function sla_timer_column_present() {
  var result = false
  $("table.list.issues thead th").each(function () {
    if (this.className == "sla_timer") {
      result = true
      return false
    }  
  })
  return result
}

function update_sla_timers(data) {
  if (!sla_timer_column_present()) { return }

  var issue_ids = []
  $("table.list.issues tbody tr").each(function () {
    if (this.id == null) { return }

    var id = this.id.split("-")[1]
    if (id == null) { return } 
    
    issue_ids.push(id)
  })
  if (issue_ids.length == 0) { return false }


  $.getJSON(
    'issues_sla_timer_update.json',
    { ids: issue_ids },
    function(data){
      sla_timer_refresh(data);
    }
  );
}

function sla_timer_refresh(data) {
  if (data == null) { return }
  if (!Array.isArray(data)) { return }

  data.forEach(function(timer){
    if (timer.id != null) {
      selector = `table.list.issues tbody tr#issue-${timer.id} td.sla_timer span`
      if ($(selector).length >= 1) {
        $(selector)[0].innerText = timer.time
      }
    }
  })
}

