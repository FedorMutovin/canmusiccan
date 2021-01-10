FactoryBot.define do
  factory :spotify_track do
    spotify_id { '0q75NwOoFiARAVp4EXU4Bs' }
    name { 'Love Galore (feat. Travis Scott)' }
    artists { 'SZA' }
    image { 'https://i.scdn.co/image/ab67616d0000b2734c79d5ec52a6d0302f3add25' }
    preview do
      'https://p.scdn.co/mp3-preview/386d8e6e61b663975f10a51a0c14d5c49b73af97?cid=ea39a51e2ea24611be97554fbb2b3de9'
    end
  end
end
