module dsvdb.Load;

import vibe.vibe;

/* Create aliases from vibe for use in other programs */
alias HttpPostParams = vibe.utils.dictionarylist.DictionaryList!(string, true, 16u, false);
