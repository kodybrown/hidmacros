object TextMenuForm: TTextMenuForm
  Left = 0
  Top = 0
  Caption = 'TextMenu'
  ClientHeight = 371
  ClientWidth = 562
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar: TStatusBar
    Left = 0
    Top = 352
    Width = 562
    Height = 19
    Panels = <
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 150
      end
      item
        Width = 150
      end>
  end
  object ActionToolBar: TActionToolBar
    Left = 0
    Top = 0
    Width = 562
    Height = 26
    ActionManager = ActionManager
    Caption = 'ActionToolBar'
    ColorMap.HighlightColor = 15660791
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 15660791
    Spacing = 0
  end
  object Memo: TMemo
    Left = 0
    Top = 26
    Width = 562
    Height = 326
    Align = alClient
    Lines.Strings = (
      'Delphi Version of FS X Simconnect SDK example : "TextMenu"'
      'Implemented by Ken Adam (fsx@akadamia.co.uk)'
      '"Start Poll" - uses polling of CallDispatch'
      '"Start Event" - uses windows message handling (WM_USER+2)'
      ''
      'Use Ctrl-F1 to display a menu on screen'
      '       Ctrl-F2 to remove the menu'
      '       Select Menu item to send event and remove menu')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object ActionManager: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = StartPoll
            ImageIndex = 1
          end
          item
            Action = StartEvent
            ImageIndex = 2
          end
          item
            Caption = '-'
          end
          item
            Action = FileExit
            ImageIndex = 0
          end>
        ActionBar = ActionToolBar
      end>
    Images = Images
    Left = 320
    Top = 168
    StyleName = 'XP Style'
    object StartPoll: TAction
      Category = 'SimConnect'
      Caption = 'Start Poll'
      ImageIndex = 1
      OnExecute = StartPollExecute
    end
    object FileExit: TFileExit
      Category = 'File'
      Caption = 'E&xit'
      Hint = 'Exit|Quits the application'
      ImageIndex = 0
    end
    object StartEvent: TAction
      Category = 'SimConnect'
      Caption = 'Start Event'
      ImageIndex = 2
      OnExecute = StartEventExecute
    end
  end
  object Images: TImageList
    Left = 360
    Top = 168
    Bitmap = {
      494C010103000400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000008484840084848400848484008484
      8400848484008484840084848400848484008484840084848400FFFFFF00C6C6
      C60084848400C6C6C600FFFFFF00C6C6C6000000000000000000000000000000
      0000000000006D332700853C130095440D0096450D00873D1200703425000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000004490600055B0900066C0C00066C0C00055E0A00044C06000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008484840084848400848484008484
      840084848400848484008484840084848400848484008484840084848400FFFF
      FF0084848400FFFFFF0084848400848484000000000000000000000000007037
      2A0070372A00CD772700E8AD7000F3CCA100F4CDA300E9B17600D07C2C006F35
      29006F3529000000000000000000000000000000000000000000000000000560
      0900056009000891130009B0180009B31A0009B3190009B11900079614000568
      0C0005680C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008400000084000000840000008400
      00000000000000000000848484008484840084848400FFFFFF00FFFFFF00FFFF
      FF0084000000840000008400000084000000000000000000000086411D00C062
      0B00F0C29200FFFEFA00FDFAF600F5E3D100F5E2D000FDF8F400FFFFFD00F2C9
      9E00C66911007B3A2100000000000000000000000000000000000A6A15000A7F
      15000BB61C0009B91A0008B4180007B2160009B3190009B4190009B81A0009B9
      1A0007831000044D060000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000FF00000084000000000000000000000084848400FFFFFF00FFFFFF00FFFF
      FF0084000000000000000000000000000000000000008C451C00C1610700F7DB
      BD00FFFEFE00E0A46B00CE6D1300C75C0000C9610000CE6E1200DE9D5F00FDFA
      F700FAE5CC00C6680D006F35280000000000000000000B6A15000F85220016BD
      340011B727000BB21C0007B1160008B1170009B2190009B2190009B2190009B4
      190009BA1A000784100006670C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      000084000000FF0000008400000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000000000000000000000000000000000008C451C00ECBD8B00FFFF
      FF00DA8F4300C6560000FFFFFF00DC975100C75B0000CA620000C75B0000D583
      3300FDFAF800F3CB9F006F35280000000000000000000B6A150020BE49001BBD
      400014B730000AB21F0028BC3600DFF5E100EEFAEF0063CE6D0009B2190009B2
      190009B3190009BA1A0006670C00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000FF00000084000000FF00000000000000FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084000000000000000000000000000000A04D1000CE772100FFFDFB00E8B6
      8400D06B0400D06B0700FFFFFF00FFFFFF00E1A87000C95E0000CA630000C75B
      0000DFA06100FFFFFF00CF7B280070352500087210001B9A3A002AC65B001DBB
      45000EB425000BB31B0011B421009ADFA000FFFFFF00F7FDF8005ACB650009B2
      190009B2190009B81A0008941300045D09000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      000084000000FF0000008400000000000000FFFFFF00FFFF0000FFFFFF00FFFF
      000084000000000000000000000000000000AF550700E5AA6F00FFFFFF00DD8F
      3F00DA812800D87B1E00FFFFFF00FFFFFF00FFFFFF00EAC19800CC670800C95F
      0000CE6E0D00FDFAF600E9B1750070352500087210002AB65B002CC5650022BD
      4D000FB422000AB21A000CB31C000AB219008DDB9500FDFEFD00F6FCF70058CB
      630009B2190009B51A0008AB1700045D09000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000FF00000084000000FF00000000000000FFFF0000FFFFFF00FFFF0000FFFF
      FF0084000000000000000000000000000000BB5F0A00F0CAA100FCF4ED00E193
      4300E2924200DF8A3400FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3DEC600CF70
      1700C95F0000F5E3D000F3CEA400703525000F821C0037C26C0033C76C00CDF1
      DA00C9EFD300C7EED000C8EFD200C5EED000C7EECF00F8FDF900FFFFFF00F2FB
      F3006FD2790008B4190009B3190005650B000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      000084000000FF0000008400000000000000FFFFFF00FFFF0000FFFFFF00FFFF
      000084000000000000000000000000000000C1650F00F2CDA600FDF7F000E9A1
      5800E9A05600E6994A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00EBC39B00CD6A
      0D00C9610000F6E6D400F3CCA10070352500138D230058CC830042C97700FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FDFEFD00FFFFFF00FFFF
      FF00BCEAC1000AB41A0009B31900066D0D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000FF00000084000000FF00000000000000FFFF0000FFFFFF00FFFF0000FFFF
      FF0084000000000000000000000000000000C1640D00EEBC8800FFFFFF00F1B8
      7C00F0AE6900EEA75F00FFFFFF00FFFFFF00FFFFFF00E7B17A00CE690200C961
      0000CF711100FEFCFA00E7AC6D00703525000F911D006FD293005FD38D006DD4
      950072D6990071D6980072D6990064D28C0092DFA800FBFEFB00FFFFFF00ACE5
      B8002EBF4C0011B82B0008B1190005610A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008400
      0000840000008400000084000000840000008400000084000000840000008400
      000084000000000000000000000000000000BF600600E5A05900FFFDFA00FBE0
      C400F8BA7B00F4B47100FFFFFF00FFFFFF00E8AB6D00D87B1D00D2741400C85C
      0000E2AA7100FFFFFE00CC752000703525000F911D0067CC83009BE5BA0038C6
      700030C3690038C56F0038C56F0070D69700E8F8EE00FFFFFF009FE2B10020BD
      48001AB93E0010BA290008A3170005610A000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C3620400FAD9B800FFFF
      FF00FEDCB800F7B87700FFFFFF00EBAD6D00E08D3700DA822800D06B0500DB92
      4A00FFFFFF00EFC08C006B342C00000000000000000025AE3900BCEDD20082DB
      A40028C063002FC2670053CD8200F7FDF900FFFFFF009CE2B20022BC4B001DBA
      410018B7360014C030000A851700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000C3620400E79E5500FEEB
      D700FFFFFF00FBDFC300F1B57800E89F5500E2944500DE914200E8B78600FFFF
      FF00F6D8B700BE5F06006B342C00000000000000000025AE390071D28C00D2F4
      E10080DAA30036C46D0039C56F00BCECCE00ABE6C2002DC2630024BE560023BC
      4D001FC1460016AE34000A851700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000840000008400000084000000840000000000000000
      0000000000000000000000000000000000000000000000000000C6670C00E69E
      5500FAD9B600FFFBF600FFFFFF00FEF8F200FDF6EF00FFFFFF00FEF9F200ECB8
      8400BE5F0900753826000000000000000000000000000000000025AE390084D8
      9F00DBF7EA00AFE8C6006BD4930052CC810044C9780049CA7B0048CB780039CB
      6A0021B649000F7C1F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C060
      0500C0600500E49F5A00EEBA8600F2CAA000F0C59900E4A76800CC741E00783A
      2700783A270000000000000000000000000000000000000000000000000025AE
      390025AE3900ADE8C500CCF2DE00BAEDD100A6E7C20091E2B30064D492002FB1
      57002FB157000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000B65C0A00B8601200B9611300B25A0F00A24F0E008E451A000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000032B74E0025AE390025AE390025AE390025AE390024A342000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF000000F81FF81F00000000E007E0070000
      0000C003C0030000E007800180010000E007800180010000E007000000000000
      E007000000000000E007000000000000E007000000000000E007000000000000
      E007000000000000FFFF800180010000F81F800180010000F81FC003C0030000
      F81FE007E0070000FFFFF81FF81F000000000000000000000000000000000000
      000000000000}
  end
end
