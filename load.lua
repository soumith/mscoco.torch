if paths.filep('instances_train2014.tds.t7') then
   print('File already saved at instances_train2014.tds.t7! Nothing to do...')
   os.exit(0)
end

if not paths.filep('instances_train2014.table.t7') then
   local json = require 'dkjson'
   local path = 'annotations/instances_train2014.json'
   local f = io.open(path)
   local str = f:read('*all')
   f:close()

   m = json.decode(str)
   torch.save('instances_train2014.table.t7', m)
   print('Saved instances_train2014.table.t7')
   print('Rerun the file again to convert from table to tds based data structure')
   os.exit(0)
end

m = torch.load('instances_train2014.table.t7')
local tds = require 'tds'

function recursiveTypeTableToTDS(m)
   local tp = torch.type(m)
   if tp == 'table' then
      local out = tds.hash()
      for k,v in pairs(m) do
	 out[k] = recursiveTypeTableToTDS(v)
      end
      return out;
   elseif tp == 'string' or tp == 'number' then
      return m
   else
      error('unhandled type:', tp)
   end
end

m = recursiveTypeTableToTDS(m)
torch.save('instances_train2014.tds.t7', m)
collectgarbage(); collectgarbage();

