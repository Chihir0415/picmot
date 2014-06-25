//
//  MotDetailViewController.m
//  picmot
//
//  Created by Chihiro Murata on 2014/03/12.
//  Copyright (c) 2014年 Chihiro Murata. All rights reserved.
//

#import "MotDetailViewController.h"

@interface MotDetailViewController (){
    int _currentPage;
}
@end

@implementation MotDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // ページの番号を保持するcurrentPageの初期化
    _currentPage = 1;
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    
    //名言[@"Life",@"Love",@"Work",@"Dream",@"Funny",@"Proverb",@"For Lady",@"Words of the greats"]
    NSArray *myArr1 = [[NSArray alloc]initWithObjects:@"\nTo be, or not to be: that is the question.\n\n生きるべきか、死ぬべきか。\nそれが問題だ。\n\n\n\nShakespeare \n（シェイクスピア）\n（英国の劇作家、詩人 / 1564～1616）\n\n",
                       @"\nMy life didn’t please me, \nso I created my life.\n\n私の人生は楽しくなかった。\nだから私は自分の人生を創造したの。\n\n\n\nCoco Chanel　\n（ココ・シャネル）\n（フランスの女性ファッションデザイナー / 1883～1971）\n\n",
                       @"\nThere is more to life than increasing its speed.\n\n速度を上げるばかりが、人生ではない。\n\n\n\nGandhi\n(ガンジー)\n（インドの弁護士、宗教家、政治指導者 / 1869～1948）",
                       @"\nChange before you have to.\n\n変革せよ。変革を迫られる前に。\n\n\n\nJackWelch\n(ジャック・ウェルチ)\n（米国の実業家 / 1935～）",
                       @"\nDo not suppose opportunity \nwill knock twice at your door.\n\nチャンスが二度も扉をたたくと思うな。\n\n\n\nChamfort\n(シャンフォール)\n（フランスの劇作家、作家 / 1741～1794）",
                       @"\n(※)Not a career. This is my life.\n\nキャリアではない。私の人生なんだ。\n\n\n\nSteve Jobs\n(スティーブ・ジョブズ)\n（米国の実業家、アップル創業者 / 1955～2011）\n\n\n※not original",
                       @"\nEverything is practice.\n\nすべては練習のなかにある。\n\n\n\nAbédi Pelé\n(ペレ)\n（ブラジルの元サッカー選手、サッカーの王様と称される / 1940～）",
                       @"\nNo one has ever drowned in sweat.\n\n汗で溺れた者はいない。\n\n\n\nLou Holtz\n(ルー・ホルツ)\n（米国のカレッジフットボールコーチ / 1937～）",
                       @"\nOur life is our art.\n\n僕らの人生は、僕らのアートなのさ。\n\n\n\nJohn Winston Lennon\n(ジョン・レノン)\n（英国のミュージシャン、ビートルズのリーダー / 1940～1980）",
                       @"\nStay hungry. Stay foolish.\n\nハングリーであれ。愚か者であれ。\n\n\n\nSteve Jobs\n(スティーブ・ジョブズ)\n（米国の実業家、アップル創業者 / 1955～2011）",
                       @"\nWe keep moving forward,\nopening new doors, \nand doing new things, \nbecause we're curious and curiosity \nkeeps leading us down new paths. \n\n好奇心はいつだって、\n新しい道を教えてくれる。\n\n\n\nWalt Disney\n(ウォルト・ディズニー)\n（米国のエンターテイナー、実業家 / 1901～1966）",
                       @"\nThere is always light behind the clouds.\n\n雲の向こうは、いつも青空。\n\n\n\nLouisa May Alcott\n(ルイーザ・メイ・オルコット)\n（米国の女性小説家 / 1832～1888）",
                       @"\nToday, which you have spent idly,\nis the tomorrow of somebody who died yesterday\nand was desperate to live.\n\nあなたが空しく生きた今日は\n昨日死んでいった者が\nあれほど生きたいと願った明日。\n\n\n\n 趙　昌仁　著(Cho Chong)\n小説『カシコギ』より",
                       @"\nHappiness is a perfume \nyou cannot pour on others\nwithout getting a few drops on yourself.\n\n幸せとは香水のようなもの。\n他人にふりかけることで、\n自分にも数滴かかる。\n\n\n\nRalph W. Emerson\n(ラルフ・Ｗ．エマーソン)\n （アメリカの詩人, 1803-1882 )",
                       @"\nLife is a tragedy when seen in close-up,\nbut a comedy in long-shot.\n\n人生はクローズアップして見ると悲劇だが、\n距離を置いて見ると喜劇である。\n\n\n\nCharlie Chaplin\n(チャーリー・チャプリン)\n（アメリカの俳優、1889-1977 )",
                       @"\nTalent is God-given, so be thankful\nPraise is man-given, so be humble.\nConceit is self-given, so be careful.\n\n才能は神が与えたもの、だから感謝しなさい。\n賞賛は人間が与えたもの、だから謙虚になりなさい。\n自惚れは自分が与えたもの、だから用心しなさい。\n\n\n\nTony Danki\n(トニー・ダンキ)\n(アメリカのアメフトのコーチ）",nil];
    NSArray *myArr2 = [[NSArray alloc]initWithObjects:@"\nLove is best.\n\n愛は最上なり。\n\n\n\nRobert Browning　\n（ロバート・ブラウニング）\n(英国の詩人 / 1812～1889）\n\n",
                       @"\nA wise girl kisses but doesn’t love,\n listens but doesn’t believe,\n and leaves before she is left.\n\n頭のいい女の子は、キスはするけど愛さない。\n 耳を傾けるけど信じない。\nそして捨てられる前に捨てる。\n\n\n\nMarilyn Monroe　\n（マリリン・モンロー）\n（米国の女優 / 1926～1962）\n\n",
                       @"\nYou must love him, ere to you.\n He will seem worthy of your love.\n\n自分の愛に値する相手かどうか、\n考える前に愛せよ。\n\n\n\nWilliam Wordsworth\n（ウィリアム・ワーズワース）\n（英国のロマン派詩人 / 1770～1850）\n\n",
                       @"\nA man falls in love through his eyes, \na woman through her ears.\n\n男は目で恋に落ち、女は耳で恋に落ちる。\n\n\n\nWoodrow Wyatt\n（ウッドロー・ワイヤット）\n（英国の政治家、作家、ジャーナリスト / 1918～1997）\n\n",
                       @"\nLove is like a flower – you’ve got to let it grow.\n\n愛とは、育てなくてはいけない花のようなもの。\n\n\n\nJohn Lennon\n（ジョン・レノン）\n（英国のミュージシャン、ビートルズのリーダー / 1940～1980）\n\n",
                       @"\nLove fed fat soon turns to boredom.\n\nみちたりてしまった恋は、\nすぐに、退屈になってしまうものである。\n\n\n\nOvid　\n（オヴィディウス）\n（古代ローマの詩人 / 紀元前43～紀元17）\n\n",
                       @"\nThe course of true love never did run smooth.\n\n真の恋の道は、茨の道である。\n\n\n\nShakespeare\n（シェイクスピア）\n（英国の劇作家、詩人 / 1564～1616）\n\n",
                       @"\nIf you would be loved, love and be lovable.\n\n愛されたいなら、愛し、愛らしくあれ。\n\n\n\nBenjamin Franklin\n（ベンジャミン・フランクリン）\n（米国の政治家、外交官、著述家、物理学者、気象学者 / 1706～1790）\n\n",
                       @"\nMr. Right is coming. \nBut he’s in Africa and he’s walking.\n\n運命のひとは必ずあらわれる。\nただ彼は今頃アフリカあたりにいて、\nしかも徒歩でこっちに向っているにちがいないわ。\n\n\n\nOprah Gail Winfrey\n(オプラ・ウィンフリー)\n（米国の女性テレビ司会者、女優 / 1954～）",
                       @"\nYou never know, \nmaybe that’s the day she has a date with destiny. \n And it’s best to be as pretty as possible for destiny.\n\nその日、ひょっとしたら、\n運命の人と出会えるかもしれないじゃない。\nその運命のためにも、\nできるだけかわいくあるべきだわ。\n\n\nCoco Chanel\n(ココ・シャネル)\n（フランスの女性ファッションデザイナー / 1883～1971）",
                       @"\nYour love makes me at once the happiest \nand the unhappiest of men.\n\n君の愛は、私を最も幸せな男にするのと同時に\n最も不幸な男にもする。\n\n\n\nLudwig van Beethoven\n(ベートーヴェン)\n（ドイツの作曲家 / 1770～1827）",
                       @"\nWe waste time looking for the perfect lover, instead of creating the perfect love.\n\n私たちは完璧な愛を創る代わりに、\n完璧な恋人を探そうとして時を無駄にしている。\n\n\n\nTom Robbins\n(トム・ロビンズ)\n（米国の小説家 / 1936～）",nil];
    NSArray *myArr3 = [[NSArray alloc]initWithObjects:@"\nGenius is 1 percent inspiration and \n99 percent perspiration.\n\n天才とは、\n1％のひらめきと99％の努力である。\n\n\n\nThomas Alva Edison\n(トーマス・エジソン)\n（米国の発明家、起業家 / 1847～1931）",
                       @"\n(※)I'm still 30 years old.\nI have something to  want to achieve still.\n\n僕は三十歳、まだまだ成し遂げたいことがある。\n\n\n\nSteve Jobs\n(スティーブ・ジョブズ)\n（米国の実業家、アップル創業者 / 1955～2011）\n\n\n※not original",
                       @"\nA problem is your chance to do your best.\n\n困難とは、ベストを尽くせるチャンスなのだ。\n\n\n\nEdward Kennedy Duke Ellington\n(デューク・エリントン)\n（米国のジャズオーケストラリーダー / 1899～1974）",
                       @"\nVictory is sweetest when you’ve known defeat.\n\n敗北を味を知ってこそ、\n最も甘美な勝利が味わえる。\n\n\n\nMalcolm Stevenson Forbes\n(マルコム・フォーブス)\n（米国のフォーブス誌の元発行人 / 1919～1990）",
                       @"\nOne of these days is none of these days.\n\n「いつの日か」は、決してやってこない。\n\n\n\nBohn, Henry George\n(ヘンリー・ジョージ・ボーン)\n（英国の出版業経営者 / 1796～1884）",
                       @"\nBelieve and act as if it were impossible to fail.\n\n失敗なんてありえないと信じて、\nやってみるんだ。\n\n\n\nCharles Franklin Kettering\n(チャールズ・ケタリング)\n（米国の農民、教員、科学者、発明家 / 1876～1958）",
                       @"\nNever complain. Never explain.\n\n不平を言わない。言い訳をしない。\n\n\n\nKatharine Houghton Hepburn\n(キャサリン・ヘプバーン)\n（米国の女優 / 1907～2003）",
                       @"\n(※)The person who can succeed are \nchallenged with the premise \n〈do not go your way is happens is natural〉.\n\n成功できる人っていうのは、\n「思い通りに行かない事が起きるのはあたりまえ」\nという前提を持って挑戦している。\n\n\n\nThomas Alva Edison\n(トーマス・エジソン)\n（米国の発明家、起業家 / 1847～1931）\n\n\n※not original",
                       @"\nYour regrets aren’t what you did,\n but what you didn’t do. \nSo I take every opportunity.\n\n後悔とは、\nやってしまったことにするもんじゃなくて、\nやらなかったことにするもの。\nだから私はチャンスがきたら必ずトライするわ。\n\n\n\nCameron Michelle Diaz\n(キャメロン・ディアス)\n（米国の女優 / 1972～）",
                       @"\nI have failed many times,\nand that's why I am a success.\n\nぼくは何度も失敗した。\nそれが成功した理由だ。\n\n\n\nMichael Jordan\n(マイケル・ジョーダン)\n（アメリカのバスケットボール選手、1963- )",
                       @"\nThe wise love to learn,\nwhile fools love to teach.\n\n愚者は教えたがり、\n賢者は学びたがる。\n\n\n\nAnton Pavlovich Chekhov\n(アントン・パヴロヴィチ・チェーホフ )\n（ロシアの作家, 1860-1904 ）",
                       @"\nThe achievement of one goal \nis the starting point of another.\n\n1つの目標達成は新たな目標の出発点だ。\n\n\n\nAlexander Graham Bell\n(アレクサンダー・グラハム・ベル)\n (アメリカの電話発明者）\n",nil];
       NSArray *myArr4 = [[NSArray alloc]initWithObjects:@"\nWomen like a man with a past, \nbut they prefer a man with a present.\n\n女性は過去を持った男が好き。\nでもプレゼント(現在)を持った男はもっと好き。\n\n\n\nMae West\n（メイ・ウエスト）\n（米国の女優 / 1893～1980）",
                       @"\nFriendship is an arrangement by which \nwe undertake to exchange small favors for big ones.\n\n友情とは、誰かに小さな親切をしてやり、\nお返しに大きな親切を期待する契約である。\n\n\n\nMontesquieu\n（モンテスキュー）\n（フランスの哲学者、三権分立論を提唱 / 1689～1755）",
                       @"\nTime passes, and little by little everything that we have spoken in falsehood becomes true.\n\n時は過ぎゆく。そして少しずつ、\n我々が口にしてきた嘘は、真実になる。\n\n\n\nMarcel Proust\n（マルセル・プルースト）\n（フランスの作家 / 1871～1922）",
                       @"\nThe optimist sees the doughnut, \nthe pessimist sees the hole.\n\n楽観主義者はドーナツを見て、\n悲観主義者はその穴をみる。\n\n\n\nOscar Wilde\n（オスカー・ワイルド）\n（アイルランドの詩人、作家、劇作家 / 1854～1900）",
                       @"\nWear a smile and have friends; \nwear a scowl and have wrinkles.\n\n笑顔を浮かべれば、友達ができます。\nでも、しかめっ面を浮かべれば、\nしわができます。\n\n\n\nGeorge Eliot\n（ジョージ・エリオット)\n（英国の女性作家 / 1819～1880）",
                       @"\nQuitting smoking is easy.\n I’ve done it a thousand times.\n\n禁煙なんて簡単さ。\n私はもう何千回もやめてきたのだから。\n\n\n\nMark Twain\n（マーク・トウェイン）\n（米国の作家、小説家 / 1835～1910）",
                       @"\nGod heals, and the doctor takes the fee.\n\n神が病を癒し、医者が料金を取る。\n\n\n\nBenjamin Franklin\n（ベンジャミン・フランクリン）\n（米国の政治家、外交官、著述家、物理学者、気象学者 / 1706～1790）",
                       @"\nI can live for two months on a good compliment.\n\nよいお世辞があれば、\n2ヶ月はそれで生きられる。\n\n\n\nMark Twain\n（マーク・トウェイン）\n（米国の作家、小説家 / 1835～1910）",
                       @"\nLove is what happens to men and women who don’t know each other.\n\n愛とは、お互いに相手を知らない男女の間に発生するものである。\n\n\n\nW. Somerset Maugham\n（サマセット・モーム）\n（英国の劇作家、小説家 / 1874～1965）",
                       @"\nLet us leave pretty women to men with no imagination.\n\n美しい女たちのことは、\n想像力のない男たちに任せておこう。\n\n\n\nMarcel Proust\n（マルセル・プルースト）\n（フランスの作家 / 1871～1922）",
                       @"\nName the greatest of all inventors. Accident.\n\n最も偉大な発明家は誰か。\nそれは「偶然」である。\n\n\n\nMark Twain\n（マーク・トウェイン）\n（米国の作家、小説家 / 1835～1910）",
                       @"\nIntelligent women have millions of enemies\nfrom the time they were born.\nThey are all foolish men.\n\n聡明な女性は生まれながらにして、\n数百万人の敵がいる。\nそれらはすべて愚かな男たちだ。\n\n\n\nAnonymous(作者不明)",
                       @"\nPoliteness is half good manners \nand half good lying.\n\n礼儀正しさの中身は、\nよいマナーが半分、上手なうそが半分である。\n\n\n\nMary Wilson Little\n(メアリー・ウィスソン・リトル)\n(アメリカの作家、1900- ）",
                       @"\nThe best way to keep one’s word is not to give it.\n\n約束を守る最上の方法は、決して約束しないことだ	。\n\n\nNapoleon　\n（ナポレオン・ボナパルト）\n（フランスの皇帝、政治家、軍人 / 1769～1821）",
                       @"\nForgive your enemies, but never forget their names.\n\nあなたの敵を許しなさい。\nだが、その名前は決して忘れるな。\n\n\nJohn F. Kennedy　\n（ジョン・F・ケネディ）\n（米国の第35代大統領、1963年にダラスにて暗殺 / 1917～1963）",nil];
    NSArray *myArr5 = [[NSArray alloc]initWithObjects:@"\nAs you dream about everything, \nyour life is brilliant\n\n夢を見るから、人生は輝く。\n\n\n\nWolfgang Amadeus Mozart\n(モーツァルト)\n（オーストリアの作曲家、演奏家 / 1756～1791）",
                       @"\nNever let your memories be greater \nthan your dreams.\n\n過去よりも大きな夢を持とう。\n\n\n\nDouglas\n(ダグラス・アイベスター)\n（米国の経営者 / 1947～）",
                       @"\nIf you can dream it, you can do it.\n\n夢見ることができれば、それは実現できる。\n\n\n\nWalt Disney\n(ウォルト・ディズニー)\n（米国のエンターテイナー、実業家 / 1901～1966）",
                       @"\nThe future belongs to those \nwho believe in the beauty of their dreams.\n\n未来は美しい夢を信じる人のためにあります。\n\n\n\nAnna Eleanor Roosevelt\n(エレノア・ルーズベルト)\n（米国のファーストレディ、人権活動家 / 1884～1962）",
                       @"\nIf there were dreams to sell, \nwhat would you buy?\n\nもし夢を売っていたら、\nあなたはどんな夢を買いますか？\n\n\n\nThomas Lovell Beddoes\n(トーマス・ロベル・ベドス)\n（英国の詩人 / 1803～1849）",
                       @"\nThe biggest adventure you can take is to live the life of your dreams.\n\nあなたにとっての最も大きな冒険は、\nあなたの夢に生きること。\n\n\n\nOprah Gail Winfrey\n(オプラ・ウィンフリー)\n（米国の女性テレビ司会者、女優 / 1954～）",
                       @"\nThe special secret of making dreams come true can be summarized in four C’s.\n They are Curiosity, Confidence, \nCourage, and Constancy.\n\n夢をかなえる秘訣は、\n4つの「C」に集約される。\nそれは、「Curiosity – 好奇心」\n「Confidence – 自信」\n「Courage – 勇気」\nそして「Constancy – 継続」である。\n\n\nWalt Disney\n(ウォルト・ディズニー)\n（米国のエンターテイナー、実業家 / 1901～1966）",
                       @"\nDream no small dreams for they have no power to move the hearts of men.\n\n小さい夢は見るな。\nそれには人の心を動かす力がないからだ。\n\n\n\nJohann Wolfgang von Goethe\n(ゲーテ)\n（ドイツの詩人、小説家、劇作家 / 1749～1832）",
                       @"\n(※)If you want to have a dream in children, \nadult should have a dream.\n\n子供に夢を持たせたければ、\n大人こそ夢を持て。\n\n\n\nアントニオ猪木\n(Antonio inoki)\n（日本の元プロレスラー、元参議院議員 / 1943～）\n\n\n※not original",
                       @"\n夢なき者は理想なし。理想なき者は信念なし。\n信念なき者は計画なし。計画なき者は実行なし。\n実行なき者は成果なし。成果なき者は幸福なし。\nゆえに幸福を求むる者は夢なかるべからず。\n\n\n\n渋沢栄一\n(Eiichi Shibusawa)\n（日本の武士、官僚、実業家、日本資本主義の父 / 1840～1931）\n\n\n※No English",//No English
                       @"\n1年目には種をまき、2年目には水をやり、\n3年目には花を咲かせましょう。\n\n\n\n野村克也\n(Katsuya Nomura)\n（日本の元プロ野球選手、監督、野球解説者、野球評論家 / 1935～）\n\n\n※No English",//No English
                       @"\nLaughter is timeless. \nImagination has no age. \nAnd dreams are forever.\n\n笑い声は時代を超え、想像力は年を取らない。\nそして、夢は永遠のものだ。\n\n\n\nWalt Disney\n(ウォルト・ディズニー)\n（米国のエンターテイナー、実業家 / 1901～1966）",
                       @"\nIf your heart is in your dreams,\n no request is too extreme.\n\nあなたの心に夢があるなら、\nどんな願いごとも大きすぎることはない\n\n\n\nWhen You Wish Upon a Star from Pinocchio\n『星に願いを』\n（アニメ映画 『ピノキオ』の主題歌）\n",nil];
    NSArray *myArr6 = [[NSArray alloc]initWithObjects:@"\nI would rather walk with a friend in the dark,\nthan alone in the light.\n\n光の中を一人で歩むよりも、\n闇の中を友人と共に歩むほうが良い。\n\n\nHelen Keller\n（ヘレン・ケラー）\n（米国の教育家、社会福祉活動家、著作家 / 1880～1968）",
                       @"\nThe trouble is not in dying for a friend,\nbut in finding a friend worth dying for.\n\n難しいのは友のために死ぬことではない。\n命をかけるだけの価値がある友を見つけることが難しいのだ。\n\n\nMark Twain\n（マーク・トウェイン）\n（米国の作家、小説家 / 1835～1910）",
                        @"\nI wish they would only take me as I am.\n\n私はあるがままの自分を受け入れてくれることだけを望む。\n\n\nVincent van Gogh\n（ゴッホ）\n（オランダ出身のポスト印象派の画家 / 1853～1890）",
                        @"\nMy best friend is the one who brings out the best in me.\n\n最高の友は、\n私の中から最高の私を引き出してくれる友である\n\n\nHenry Ford　\n（ヘンリー・フォード）\n（米国の実業家、フォード・モーター創業者 / 1863～1947）",
                        @"\nOther men are lenses through \nwhich we read our own minds.\n\n他人とは、自分自身の心を読み取ることのできるレンズである。\n\n\nRalph Waldo Emerson　\n（エマーソン）\n（米国の思想家、哲学者、作家、詩人 / 1803～1882）",
                        @"\nA slip of the foot you may soon recover,\nbut a slip of the tongue you may never get over.\n\n足を滑らせてもすぐに回復できるが、\n口を滑らせた場合は決して乗り越えることはできない。\n\nBenjamin Franklin　\n（ベンジャミン・フランクリン）\n（米国の政治家、外交官、著述家、物理学者、気象学者 / 1706～1790）",
                        @"\nThe best way to cheer yourself up\nis to try to cheer somebody else up.\n\n自分を元気づける一番良い方法は、\n誰か他の人を元気づけてあげることだ。\n\n\nMark Twain　\n（マーク・トウェイン）\n（米国の作家、小説家 / 1835～1910）",
                        @"\nThe best way to find out \nif you can trust somebody is to trust them.\n\n誰かを信頼できるかを試すのに一番良い方法は、\n彼らを信頼してみることだ。\n\n\nErnest Hemingway　\n（ヘミングウェイ）\n米国の小説家、ノーベル文学賞受賞者 / 1899～1961）",
                        @"The proper office of a friend is to side with you \nwhen you are in the wrong. \nNearly anybody will side with you \nwhen you are in the right.\n\n正しい友人というものは、\nあなたが間違っているときに味方してくれる者のこと。\n正しいときには誰だって味方をしてくれるのだから。\n\n\nMark Twain　\n（マーク・トウェイン）\n（米国の作家、小説家 / 1835～1910）",nil];
    NSArray *myArr7 = [[NSArray alloc]initWithObjects:@"\nHope for the best and prepare for the worst.\n\n\n最善のものを希望せよ。\nしかし最悪のものに備えよ。\n\n\n\nProverb of the West\n(西洋のことわざ)\n\n",
                       @"\n(※)What is live without a doubt, not so smart.\n\n\n間違いをせずに生きるものは、\nそれほど賢くない。\n\n\n\nFrench proverb\nフランスのことわざ\n\n\n\n※not original",
                       @"\nExperience without learning is better \nthan learning without experience.\n\n\n学問なき経験は、\n経験なき学問に勝る。\n\n\n\nBritish proverb\nイギリスのことわざ\n\n",
                       @"Let him that would be happy for a day, \ngo to the barber;\nfor a week, marry a wife;\nfor a month, buy him a new horse;\nfor a year, build him a new house;\nfor all his lifetime, be an honest man.\n一日だけ幸せでいたいならば\n床屋にいけ。\n一週間だけ幸せでいたいなら\n車を買え。\n一か月だけ幸せでいたいなら\n結婚をしろ。\n一年だけ幸せでいたいなら\n家を買え。\n一生幸せでいたいなら正直でいることだ。\n\nBritish proverb\nイギリスのことわざ",
                       @"\n(※)Chess is finished, \nthe king also infantry also are \ngoing back in the same box.\n\n\nチェスが終われば、\n王様も歩兵も同じ箱に帰る。\n\n\nItaly proverb\nイタリアのことわざ\n\n\n\n※not original",
                       @"\n(※)After happiness has left,gives off light.\n\n\n幸せは去ったあとに\n光を放つ。\n\n\n\nBritish proverb\nイギリスのことわざ\n\n\n\n※not original",
                       @"\n(※)Opportunity than abandon the people, \nbetter people abandon the opportunity in many cases.\n\n\n機会が人を見捨てるよりも、\n人が機会を見捨てるほうが多い。\n\n\n\nFrench proverb\nフランスのことわざ\n\n\n\n※not original",
                       @"\nBetter 〈thank God〉 \nrather than 〈God forbid.〉\n\n\n「神様お願いします」より\n「神様のおかげです」がいい。\n\n\n\nRussia proverb\nロシアのことわざ\n\n",
                       @"\n(※)Unfortunate people should have hope.\nBut happy people beware.\n\n\n不幸な人は希望をもて。\n幸福な人は用心せよ。\n\n\n\nLatin proverb\nラテンのことわざ\n\n\n\n※not original",
                       @"\n(※)What you want to warm up after taking a year,\nmake a fireplace while young.\n\n\n年をとってから暖まりたいものは、\n若いうちに暖炉を\n作っておかなければならない。\n\n\nGermany proverb\nドイツのことわざ\n\n\n\n※not original",
                       @"\n(※)Thing I knew the taste of bitterness \ndo not know even sweetness.\n\n\n苦さの味を知らぬものは\n甘さもわからない。\n\n\n\nGermany proverb\nドイツのことわざ\n\n\n\n※not original",
                       @"\n(※)Who spit in the well, \nmust drink the water someday.\n\n\n井戸に唾を吐く者は、\nいつかその水を飲まなければならない。\n\n\n\nJudea proverb\nユダヤのことわざ\n\n\n\n※not original",
                       @"\n(※)The dance together when people dance.\n\n\n人が踊る時は一緒に踊れ。\n\n\n\nGermany proverb\nドイツのことわざ\n\n\n\n※not original",
                       @"\nEat to live, but do not live to eat.\n\n\n食べるために生きるな。\n生きるために食べよ。\n\n\n\nBritish proverb\nイギリスのことわざ\n\n",
                       @"\nLooking at yourself is the hardest of all.\nCriticizing others is the easiest of all.\n\nこの世で一番難しいのは自分を見つめること。\n一番たやすいのは他人を批判すること。\n\n\n\nBritish proverb\nイギリスのことわざ\n\n",
                       @"\nWhen you give up dreaming, you are lost.\n\n夢見る気持ちを失った人は迷子である。\n\n\n\nAboriginal proverb\nアボリジニのことわざ\n\n",
                       @"\nImitation is the sincerest form of flattery.\n\n真似することは心からの賛辞である。\n\n\n\nProverb(ことわざ)",
                       @"\nLove me little and love me long.\n\n少し愛して、長く愛して。\n\n\n\nProverb(ことわざ)",nil];
    NSArray *myArr8 = [[NSArray alloc]initWithObjects:@"\nDressing is a way of life.\n\n服装は生き方である。\n\n\n\nYves Saint-Laurent\n(イヴ・サン＝ローラン)\n（フランスのファッションデザイナー / 1936～2008）",
                       @"(※)At one time or another, \na woman let me love a bad man in life.\nBut why, is it can feel to thank \nwhen I met a good man.\n\n女は、人生で一度や二度は、\nワルい男を愛してしまうの。\nでもだからこそ、イイ男に出会ったとき、\n感謝する気持ちになれるのよ。\n\n\n\nMarjorie Kinnan Rawlings\n(マージョリー・キナン・ローリングス)\n（米国の女性作家 / 1986～1953）\n\n\n※not original",
                       @"(※)Because should be for yourself \nin your own life,\nwaiting the prince riding a white horse\n just to make for happiness yourself useless.\nIn own future, we must open up on their own.\n自分の人生には、\n自分で責任を持つべきだから、\nただ自分を幸せにしてくれる白馬にまたがった\n王子様を待っているなんてダメ。\n自分の将来は、\n自分で切り開いていかなきゃね。\n\n\nCameron Michelle Diaz\n(キャメロン・ディアス)\n（米国の女優 / 1972～）\n\n※not original",
                       @"\n(※)The more who cried a lot \neyes wash with tears,\n field of view becomes widely.\n\n\n涙で目が洗えるほどたくさん泣いた女は、\n視野が広くなるの。\n\n\nDorothy Dix\n(ドロシー・ディックス)\n（米国のジャーナリスト / 1861～1951）\n\n\n※not original",
                       @"\nFor attractive lips, speak words of kindness.\nFor lovely eyes, seek out the good in people\n\n\n魅力的な唇のためには、\n優しい言葉を紡ぐこと。\n愛らしい瞳のためには、\n人々の素晴らしさを見つけること\n\n\nAudrey Hepburn\n(オードリー・ヘップバーン)\n（英国の女優 / 1929～1993）",
                       @"\nAdornment, what a science!Beauty,\n what a weapon!Modesty, what elegance!\n\n\n美しさは女性の「武器」であり、\n装いは「知恵」であり、\n謙虚さは「エレガント」である。\n\n\nCoco Chanel\n（ココ・シャネル）\n（フランスの女性ファッションデザイナー / 1883～1971）",
                       @"\n(※)恋愛がうまく行かない時は、\n良い仕事が来るもの。\n幸せを全部手に入れようとしたら命と引き換え。\n正負の法則であり地球の法則。\n\n\n\n美輪明宏\n(Akihiro Miwa)\n（日本のシンガーソングライター、俳優、演出家 / 1935～）\n\n\n※No English",//No English
                       @"\nBeautiful young people are accidents of nature,\n but beautiful old people are works of art.\n\n\n若くて美しいことは、\n自然のいたずら。\n年をとっても美しいことは芸術です。\n\n\nAnna Eleanor Roosevelt\n(エレノア・ルーズベルト)\n（米国のファーストレディ、人権活動家、世界人権宣言の起草者 / 1884～1962）",
                       @"\n(※)Talking is the last refuge.\n\n\nおしゃべりこそ、\n最後の逃げ場。\n\n\n\nZora Neale Hurston\n(ゾラ・ニール・ハーストン)\n（米国の黒人女性作家 / 1891～1960）\n\n\n※not original",
                       @"(※)Not only cleaning and cooking and child care,\nthere are more important things in life.\nI do not want to send life \nto wash the dishes.\n\n\n料理や育児や掃除だけじゃなく、\n人生にはもっと大切なことがある。\n私は食器を洗って一生を送りたくない。\n\n\nMargaret Hilda Thatcher\n(マーガレット・サッチャー)\n（英国初の女性首相 / 1925～2013）\n\n\n※not original",
                       @"\nPeople laughed at the way I dressed,\nbut that was the secret of my success.\nI didn't look like anyone.\n\n\nみんな、私の着ているものを見て笑ったわ。\nでもそれが私の成功の鍵。\nみんなと同じ格好をしなかったからよ。\n\n\nCoco Chanel\n(ココ・シャネル)\n（フランスの女性ファッションデザイナー / 1883～1971）",
                       @"\n(※)Woman, please independence.\nStand on their feet.\n\n\n女性よ自立しなさい。\n自分の足で立ちなさい。\n\n\n\nFlorence Nightingale\n(ナイチンゲール)\n（英国の看護師、社会起業家、看護教育学者 / 1820～1910）\n\n\n※not original",
                       @"\n I'm very definitely a woman and I enjoy it.\n\n\n私は女だし、\n女であることを\n楽しんでるわ。\n\n\nMarilyn Monroe\n（マリリン・モンロー）\n（米国の女優 / 1926～1962）",
                       @"\nA woman without perfume \nis a woman without future.\n\n\n香水をつけない女性に\n未来はない。\n\n\nCoco Chanel\n(ココ・シャネル)\n（フランスの女性ファッションデザイナー / 1883～1971）",
                       @"\n I don't want to make money, \nI just want to be wonderful.\n\n\nお金が欲しいんじゃない。\nただ、素晴らしい女になりたいの。\n\n\nMarilyn Monroe\n（マリリン・モンロー）\n（米国の女優 / 1926～1962）",
                       @"\n人から多くの好意を寄せられる人は、\nその分多くの嫉妬も受ける。\n美しく生まれた人にはそれがハンデとなる。\n\n\n\n美輪明宏\n(Akihiro Miwa)\n（日本のシンガーソングライター、俳優、演出家 / 1935～）\n\n\n※No English",//No English
                       nil];
    NSArray *myArr9 = [[NSArray alloc]initWithObjects:@"\nAll it takes is faith and trust.\n\n必要なのは、ただ信じる事さ。\n\n\nピーター・パン",
                       @"\nThey can't order me to stop dreaming.\n\n夢を見ることは、誰にも止められないわ。\n\n\nシンデレラ",
                       @"\nIf you keep on believing, \nthe dreams that you wish will come true.\n\n信じていれば、夢は叶う。\n\n\nシンデレラ",
                       @"\nThe world's a stage and \nit is time for your debut.\n\n世界は君を待っているよ。\n\n\nフィニアスとファーブ",
                       @"\nAlways let your conscience be your guide.\n\n常に良心に従いなさい。\n\n\nピノキオ",
                       @"\nDo what you think is right.\n\n君が正しいと思うことをしろ。\n\n\nノートルダムの鐘",
                       @"\nThe flower that blooms in adversity \nis the rarest and most beautiful of all.\n\n逆境に咲く花は、\nもっとも貴重でもっとも美しい。\n\n\nムーラン",
                       @"\nI know it's tough,\nbut heroes have to make the tough choices sometimes.\n\n悲しいことだが、ヒーローには\n辛い決断をしなければならん時もあるのだ。\n\n\nシュガー・ラッシュ",
                       @"\nKeep your chin up.\nSomeday there will be happiness again.\n\n元気を出して。\nいつかまた幸せが訪れるさ。\n\n\nロビン・フッド",
                       @"\nYou're braver than you believe,\nand stronger than you seem,\nand smarter than you think.\n\n君は自分で思っているより\nずっと勇敢だし、強いし、頭もいいんだ。\n\n\nくまのプーさん",
                       @"\nAll at once everything looks different,\nnow that I see you.\n\nあなたといると、何もかも違って見える。\n\n\n塔の上のラプンツェル",
                       @"\nLost forever if I never knew you.\n\nもしあなたと出会わなければ、\n永遠に迷子だった。\n\n\nポカホンタス",
                       @"\nTrust me!\n\n僕を信じて！\n\n\nアラジン",
                       @"\nIt is not what is outside,\nbut what is inside that counts!\n\n大事なのは外見じゃない、中身だ！\n\n\nアラジン",
                       @"\nYou're the one,\nthe one that I've been looking for!\n\n君こそ、僕のずっと探し求めていた人だ！\n\n\nリトル・マーメイド",
                       @"\nLike a bolt out of the blue,\nFate steps in and sees you through.\n\n運命は稲妻のように突然訪れ、心を射抜く。\n\n\nピノキオ",
                       @"\nYou are my new dream.\n\n君が僕の新しい夢だ。\n\n\n塔の上のラプンツェル",
                       @"\nEvery hour we spent together,\nlives within my heart.\n\n共に過ごした日々は、\n今も心の中に生きている。\n\n\nトイ・ストーリ―2",
                       @"\nSometimes it's better to be alone.\n\nひとりでいるほうが良かったりもするものよ。\n\n\nヘラクレス",
                       @"\nAll females is poison!\nThey're full of wicked wiles!\n\n女は有害だ！\nやつらは謀略に満ちあふれてる！\n\n\n白雪姫",
                       @"\nIf there's a prize for rotten judgment,\nI guess I already won that.\n\n間違った判断だったの。\nその報いは受けたと思うわ。\n\n\nヘラクレス",
                       @"\nEverybody deserves true love.\n\n誰だって真の愛に出会う資格はある。\n\n\nシンデレラ3",
                       @"\nI let her go,\n ...because I love her!\n\n彼女を自由にした。…愛しているから。\n\n\n美女と野獣",
                       nil];
    //NSArray *myArr10 = [[NSArray alloc]initWithObjects:@"作成中...",nil];  お気に入り画面を作成する

    
    
    NSArray* Array = @[myArr1,myArr2,myArr3,myArr4,myArr5,myArr6,myArr7,myArr8,myArr9];
   // NSLog(@"Array = %@",Array[0][5]);
    
    int n = (int)[Array[_i] count];
    
    
    // UIScrollViewに表示するコンテンツViewを作成する。
    CGSize s = scrollView.frame.size;
    CGRect contentRect = CGRectMake(0, 0, s.width * n, s.height);
    UIView *contentView = [[UIView alloc] initWithFrame:contentRect];
    
    //背景画像を変える
    UIImageView *backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320, 586)];
    UIImage *image = [UIImage imageNamed:@"slice1.png"];
    backimage.contentMode = UIViewContentModeScaleToFill;
    [backimage setImage:image];
    [self.view addSubview:backimage];
    backimage.alpha = 0.3;
    
    UIView* view[n];
    UITextView* textView[n];
    for (int i = 0; i < n; i++) {
        view[i] = [[UIView alloc] init];
        view[i].tag = i;
        view[i].frame = CGRectMake(320 * i, 30, s.width, s.height-20);
        
        textView[i] = [[UITextView alloc]init];
        textView[i].tag = i;
        textView[i].frame =CGRectMake(320 * i, 100, s.width, s.height-130);
        textView[i].font = [UIFont systemFontOfSize:14];
        textView[i].text = Array[_i][i];
        textView[i].textAlignment = NSTextAlignmentCenter;
        
       // view[i].backgroundColor = [UIColor clearColor];
        textView[i].editable = NO;
        
        [contentView addSubview:view[i]];
        [contentView addSubview:textView[i]];
    }
    
    // スクロールViewにコンテンツViewを追加する。
    [scrollView addSubview:contentView];
    
    // スクロールView上のコンテンツViewのサイズを指定します。
    scrollView.contentSize = contentView.frame.size;
    
    // 初期表示するコンテンツViewの場所を指定します。
    // ２ページ目から表示したいときはこう↓
    //scrollView.contentOffset = CGPointMake(320, 0);
       scrollView.contentOffset = CGPointMake(0, 0);

    }



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 現在の表示位置（左上）のx座標とUIScrollViewの表示幅(320px)を用いて現在のページ番号を計算します。
    CGPoint offset = scrollView.contentOffset;
    int page = (offset.x + 160)/320;
    
    // 現在表示しているページ番号と異なる場合には、
    // ページ切り替わりと判断し、処理を呼び出します。
    // currentPageは、現在ページ数を保持するフィールド変数。
    if (_currentPage != page) {
        _currentPage = page;
       // NSLog(@"%d",_currentPage);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end