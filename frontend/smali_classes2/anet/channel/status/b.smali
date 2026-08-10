.class Lanet/channel/status/b;
.super Ljava/lang/Object;
.source "Taobao"


# static fields
.field static volatile a:Landroid/content/Context;

.field static volatile b:Z

.field static volatile c:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

.field static volatile d:Ljava/lang/String;

.field static volatile e:Ljava/lang/String;

.field static volatile f:Ljava/lang/String;

.field static volatile g:Ljava/lang/String;

.field static volatile h:Ljava/lang/String;

.field static volatile i:Ljava/lang/String;

.field static volatile j:Landroid/util/Pair;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/util/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation
.end field

.field static volatile k:Z

.field static volatile l:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/net/InetAddress;",
            ">;"
        }
    .end annotation
.end field

.field private static m:[Ljava/lang/String;

.field private static volatile n:Z

.field private static volatile o:Z

.field private static p:Landroid/net/ConnectivityManager;

.field private static q:Landroid/telephony/TelephonyManager;

.field private static r:Landroid/net/wifi/WifiManager;

.field private static s:Landroid/telephony/SubscriptionManager;

.field private static t:Ljava/lang/reflect/Method;

.field private static u:Landroid/content/BroadcastReceiver;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    const-string v0, "net.dns3"

    const-string v1, "net.dns4"

    const-string v2, "net.dns1"

    const-string v3, "net.dns2"

    .line 41
    filled-new-array {v2, v3, v0, v1}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lanet/channel/status/b;->m:[Ljava/lang/String;

    const/4 v0, 0x0

    sput-object v0, Lanet/channel/status/b;->a:Landroid/content/Context;

    const/4 v1, 0x0

    sput-boolean v1, Lanet/channel/status/b;->b:Z

    .line 46
    sget-object v2, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->NONE:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    sput-object v2, Lanet/channel/status/b;->c:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    const-string v2, "unknown"

    sput-object v2, Lanet/channel/status/b;->d:Ljava/lang/String;

    const-string v3, ""

    sput-object v3, Lanet/channel/status/b;->e:Ljava/lang/String;

    sput-object v3, Lanet/channel/status/b;->f:Ljava/lang/String;

    sput-object v3, Lanet/channel/status/b;->g:Ljava/lang/String;

    sput-object v2, Lanet/channel/status/b;->h:Ljava/lang/String;

    sput-object v3, Lanet/channel/status/b;->i:Ljava/lang/String;

    sput-object v0, Lanet/channel/status/b;->j:Landroid/util/Pair;

    sput-boolean v1, Lanet/channel/status/b;->k:Z

    .line 55
    sget-object v2, Ljava/util/Collections;->EMPTY_LIST:Ljava/util/List;

    sput-object v2, Lanet/channel/status/b;->l:Ljava/util/List;

    sput-boolean v1, Lanet/channel/status/b;->n:Z

    sput-boolean v1, Lanet/channel/status/b;->o:Z

    sput-object v0, Lanet/channel/status/b;->p:Landroid/net/ConnectivityManager;

    sput-object v0, Lanet/channel/status/b;->q:Landroid/telephony/TelephonyManager;

    sput-object v0, Lanet/channel/status/b;->r:Landroid/net/wifi/WifiManager;

    sput-object v0, Lanet/channel/status/b;->s:Landroid/telephony/SubscriptionManager;

    .line 116
    new-instance v0, Lanet/channel/status/NetworkStatusMonitor$2;

    invoke-direct {v0}, Lanet/channel/status/NetworkStatusMonitor$2;-><init>()V

    sput-object v0, Lanet/channel/status/b;->u:Landroid/content/BroadcastReceiver;

    return-void
.end method

.method constructor <init>()V
    .locals 0

    .line 38
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private static a(ILjava/lang/String;)Lanet/channel/status/NetworkStatusHelper$NetworkStatus;
    .locals 0

    packed-switch p0, :pswitch_data_0

    const-string p0, "TD-SCDMA"

    .line 213
    invoke-virtual {p1, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_1

    const-string p0, "WCDMA"

    invoke-virtual {p1, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p0

    if-nez p0, :cond_1

    const-string p0, "CDMA2000"

    invoke-virtual {p1, p0}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result p0

    if-eqz p0, :cond_0

    goto :goto_0

    .line 211
    :pswitch_0
    sget-object p0, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->G5:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    return-object p0

    .line 209
    :pswitch_1
    sget-object p0, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->G4:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    return-object p0

    .line 207
    :pswitch_2
    sget-object p0, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->G3:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    return-object p0

    .line 205
    :pswitch_3
    sget-object p0, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->G2:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    return-object p0

    .line 216
    :cond_0
    sget-object p0, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->NONE:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    return-object p0

    .line 214
    :cond_1
    :goto_0
    sget-object p0, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->G3:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    return-object p0

    :pswitch_data_0
    .packed-switch 0x1
        :pswitch_3
        :pswitch_3
        :pswitch_2
        :pswitch_3
        :pswitch_2
        :pswitch_2
        :pswitch_3
        :pswitch_2
        :pswitch_2
        :pswitch_2
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_2
        :pswitch_2
        :pswitch_3
        :pswitch_2
        :pswitch_1
        :pswitch_1
        :pswitch_0
    .end packed-switch
.end method

.method private static a(Ljava/lang/String;)Ljava/lang/String;
    .locals 3

    .line 221
    invoke-static {p0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    const-string v1, "unknown"

    if-nez v0, :cond_7

    .line 222
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p0, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p0

    const-string v0, "cmwap"

    .line 223
    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_0

    return-object v0

    :cond_0
    const-string v0, "uniwap"

    .line 225
    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_1

    return-object v0

    :cond_1
    const-string v0, "3gwap"

    .line 227
    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_2

    return-object v0

    :cond_2
    const-string v0, "ctwap"

    .line 229
    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_3

    return-object v0

    :cond_3
    const-string v0, "cmnet"

    .line 231
    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_4

    return-object v0

    :cond_4
    const-string v0, "uninet"

    .line 233
    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_5

    return-object v0

    :cond_5
    const-string v0, "3gnet"

    .line 235
    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v2

    if-eqz v2, :cond_6

    return-object v0

    :cond_6
    const-string v0, "ctnet"

    .line 237
    invoke-virtual {p0, v0}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result p0

    if-eqz p0, :cond_7

    return-object v0

    :cond_7
    return-object v1
.end method

.method static a()V
    .locals 4

    sget-boolean v0, Lanet/channel/status/b;->n:Z

    if-nez v0, :cond_0

    sget-object v0, Lanet/channel/status/b;->a:Landroid/content/Context;

    if-eqz v0, :cond_0

    .line 68
    new-instance v0, Landroid/content/IntentFilter;

    invoke-direct {v0}, Landroid/content/IntentFilter;-><init>()V

    const-string v1, "android.net.conn.CONNECTIVITY_CHANGE"

    .line 69
    invoke-virtual {v0, v1}, Landroid/content/IntentFilter;->addAction(Ljava/lang/String;)V

    :try_start_0
    sget-object v1, Lanet/channel/status/b;->a:Landroid/content/Context;

    sget-object v2, Lanet/channel/status/b;->u:Landroid/content/BroadcastReceiver;

    .line 71
    invoke-virtual {v1, v2, v0}, Landroid/content/Context;->registerReceiver(Landroid/content/BroadcastReceiver;Landroid/content/IntentFilter;)Landroid/content/Intent;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    const/4 v0, 0x0

    new-array v0, v0, [Ljava/lang/Object;

    const-string v1, "awcn.NetworkStatusMonitor"

    const-string v2, "registerReceiver failed"

    const/4 v3, 0x0

    .line 73
    invoke-static {v1, v2, v3, v0}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 75
    :goto_0
    invoke-static {}, Lanet/channel/status/b;->d()V

    const/4 v0, 0x1

    sput-boolean v0, Lanet/channel/status/b;->n:Z

    :cond_0
    return-void
.end method

.method private static a(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;Ljava/lang/String;)V
    .locals 0

    sput-object p0, Lanet/channel/status/b;->c:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    sput-object p1, Lanet/channel/status/b;->d:Ljava/lang/String;

    const-string p0, ""

    sput-object p0, Lanet/channel/status/b;->e:Ljava/lang/String;

    sput-object p0, Lanet/channel/status/b;->f:Ljava/lang/String;

    sput-object p0, Lanet/channel/status/b;->g:Ljava/lang/String;

    const/4 p1, 0x0

    sput-object p1, Lanet/channel/status/b;->j:Landroid/util/Pair;

    sput-object p0, Lanet/channel/status/b;->h:Ljava/lang/String;

    sput-object p0, Lanet/channel/status/b;->i:Ljava/lang/String;

    return-void
.end method

.method static b()V
    .locals 2

    sget-object v0, Lanet/channel/status/b;->a:Landroid/content/Context;

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/status/b;->a:Landroid/content/Context;

    sget-object v1, Lanet/channel/status/b;->u:Landroid/content/BroadcastReceiver;

    .line 82
    invoke-virtual {v0, v1}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    :cond_0
    return-void
.end method

.method private static b(Ljava/lang/String;)Z
    .locals 1

    sget-object v0, Lanet/channel/status/b;->a:Landroid/content/Context;

    .line 338
    invoke-virtual {v0, p0}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result p0

    if-nez p0, :cond_0

    const/4 p0, 0x1

    goto :goto_0

    :cond_0
    const/4 p0, 0x0

    :goto_0
    return p0
.end method

.method static c()V
    .locals 3

    sget-boolean v0, Lanet/channel/status/b;->o:Z

    if-nez v0, :cond_1

    .line 88
    invoke-static {}, Lanet/channel/status/b;->e()Landroid/net/NetworkInfo;

    move-result-object v0

    const/4 v1, 0x1

    if-eqz v0, :cond_0

    .line 89
    invoke-virtual {v0}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v0

    if-eqz v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    sput-boolean v0, Lanet/channel/status/b;->b:Z

    sget-object v0, Lanet/channel/status/b;->p:Landroid/net/ConnectivityManager;

    .line 91
    new-instance v2, Lanet/channel/status/c;

    invoke-direct {v2}, Lanet/channel/status/c;-><init>()V

    invoke-virtual {v0, v2}, Landroid/net/ConnectivityManager;->registerDefaultNetworkCallback(Landroid/net/ConnectivityManager$NetworkCallback;)V

    sput-boolean v1, Lanet/channel/status/b;->o:Z

    :cond_1
    return-void
.end method

.method static d()V
    .locals 15

    const-string v0, "wifi"

    const-string v1, "unknown"

    const-string v2, "no network"

    const-string v3, "checkNetworkStatus"

    const/4 v4, 0x0

    new-array v5, v4, [Ljava/lang/Object;

    const-string v6, "awcn.NetworkStatusMonitor"

    const-string v7, "[checkNetworkStatus]"

    const/4 v8, 0x0

    .line 132
    invoke-static {v6, v7, v8, v5}, Lanet/channel/util/ALog;->d(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    sget-object v5, Lanet/channel/status/b;->c:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    sget-object v7, Lanet/channel/status/b;->e:Ljava/lang/String;

    sget-object v9, Lanet/channel/status/b;->f:Ljava/lang/String;

    const/4 v10, 0x1

    .line 140
    :try_start_0
    invoke-static {}, Lanet/channel/status/b;->e()Landroid/net/NetworkInfo;

    move-result-object v11
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    move v12, v4

    goto :goto_0

    :catch_0
    move-exception v11

    :try_start_1
    const-string v12, "getNetworkInfo exception"

    new-array v13, v4, [Ljava/lang/Object;

    .line 142
    invoke-static {v6, v12, v8, v11, v13}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    .line 143
    sget-object v11, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->NONE:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    invoke-static {v11, v1}, Lanet/channel/status/b;->a(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;Ljava/lang/String;)V

    move-object v11, v8

    move v12, v10

    :goto_0
    const/4 v13, 0x2

    if-nez v12, :cond_6

    if-eqz v11, :cond_5

    .line 148
    invoke-virtual {v11}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v12

    if-nez v12, :cond_0

    goto/16 :goto_2

    :cond_0
    const/4 v2, 0x6

    new-array v2, v2, [Ljava/lang/Object;

    const-string v12, "info.isConnected"

    aput-object v12, v2, v4

    .line 152
    invoke-virtual {v11}, Landroid/net/NetworkInfo;->isConnected()Z

    move-result v12

    invoke-static {v12}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v12

    aput-object v12, v2, v10

    const-string v12, "info.isAvailable"

    aput-object v12, v2, v13

    invoke-virtual {v11}, Landroid/net/NetworkInfo;->isAvailable()Z

    move-result v12

    invoke-static {v12}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v12

    const/4 v14, 0x3

    aput-object v12, v2, v14

    const-string v12, "info.getType"

    const/4 v14, 0x4

    aput-object v12, v2, v14

    invoke-virtual {v11}, Landroid/net/NetworkInfo;->getType()I

    move-result v12

    invoke-static {v12}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v12

    const/4 v14, 0x5

    aput-object v12, v2, v14

    invoke-static {v6, v3, v8, v2}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    .line 153
    invoke-virtual {v11}, Landroid/net/NetworkInfo;->getType()I

    move-result v2

    if-nez v2, :cond_2

    .line 154
    invoke-virtual {v11}, Landroid/net/NetworkInfo;->getSubtypeName()Ljava/lang/String;

    move-result-object v0

    .line 155
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    const-string v2, ""

    if-nez v1, :cond_1

    :try_start_2
    const-string v1, " "

    invoke-virtual {v0, v1, v2}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object v2

    .line 156
    :cond_1
    invoke-virtual {v11}, Landroid/net/NetworkInfo;->getSubtype()I

    move-result v0

    invoke-static {v0, v2}, Lanet/channel/status/b;->a(ILjava/lang/String;)Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    move-result-object v0

    invoke-static {v0, v2}, Lanet/channel/status/b;->a(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;Ljava/lang/String;)V

    .line 157
    invoke-virtual {v11}, Landroid/net/NetworkInfo;->getExtraInfo()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lanet/channel/status/b;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lanet/channel/status/b;->e:Ljava/lang/String;

    .line 158
    invoke-static {}, Lanet/channel/status/b;->h()V

    goto :goto_1

    .line 159
    :cond_2
    invoke-virtual {v11}, Landroid/net/NetworkInfo;->getType()I

    move-result v2

    if-ne v2, v10, :cond_4

    .line 160
    sget-object v1, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->WIFI:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    invoke-static {v1, v0}, Lanet/channel/status/b;->a(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;Ljava/lang/String;)V

    .line 161
    invoke-static {}, Lanet/channel/AwcnConfig;->isWifiInfoEnable()Z

    move-result v1

    if-eqz v1, :cond_3

    .line 162
    invoke-static {}, Lanet/channel/status/b;->i()Landroid/net/wifi/WifiInfo;

    move-result-object v1

    if-eqz v1, :cond_3

    const-string v2, "android.permission.ACCESS_FINE_LOCATION"

    .line 164
    invoke-static {v2}, Lanet/channel/status/b;->b(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    .line 165
    invoke-virtual {v1}, Landroid/net/wifi/WifiInfo;->getBSSID()Ljava/lang/String;

    move-result-object v2

    sput-object v2, Lanet/channel/status/b;->g:Ljava/lang/String;

    .line 166
    invoke-virtual {v1}, Landroid/net/wifi/WifiInfo;->getSSID()Ljava/lang/String;

    move-result-object v1

    sput-object v1, Lanet/channel/status/b;->f:Ljava/lang/String;

    :cond_3
    sput-object v0, Lanet/channel/status/b;->h:Ljava/lang/String;

    sput-object v0, Lanet/channel/status/b;->i:Ljava/lang/String;

    .line 170
    invoke-static {}, Lanet/channel/status/b;->j()Landroid/util/Pair;

    move-result-object v0

    sput-object v0, Lanet/channel/status/b;->j:Landroid/util/Pair;

    goto :goto_1

    .line 172
    :cond_4
    sget-object v0, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->NONE:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    invoke-static {v0, v1}, Lanet/channel/status/b;->a(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;Ljava/lang/String;)V

    .line 174
    :goto_1
    invoke-virtual {v11}, Landroid/net/NetworkInfo;->isRoaming()Z

    move-result v0

    sput-boolean v0, Lanet/channel/status/b;->k:Z

    .line 175
    invoke-static {}, Lanet/channel/util/c;->e()V

    goto :goto_3

    .line 149
    :cond_5
    :goto_2
    sget-object v0, Lanet/channel/status/NetworkStatusHelper$NetworkStatus;->NO:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    invoke-static {v0, v2}, Lanet/channel/status/b;->a(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;Ljava/lang/String;)V

    new-array v0, v10, [Ljava/lang/Object;

    aput-object v2, v0, v4

    .line 150
    invoke-static {v6, v3, v8, v0}, Lanet/channel/util/ALog;->i(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    :cond_6
    :goto_3
    sget-object v0, Lanet/channel/status/b;->c:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    if-ne v0, v5, :cond_7

    sget-object v0, Lanet/channel/status/b;->e:Ljava/lang/String;

    .line 179
    invoke-virtual {v0, v7}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    sget-object v0, Lanet/channel/status/b;->f:Ljava/lang/String;

    invoke-virtual {v0, v9}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_9

    .line 180
    :cond_7
    invoke-static {v13}, Lanet/channel/util/ALog;->isPrintLog(I)Z

    move-result v0

    if-eqz v0, :cond_8

    .line 181
    invoke-static {}, Lanet/channel/status/NetworkStatusHelper;->printNetworkDetail()V

    :cond_8
    sget-object v0, Lanet/channel/status/b;->c:Lanet/channel/status/NetworkStatusHelper$NetworkStatus;

    .line 184
    invoke-static {v0}, Lanet/channel/status/NetworkStatusHelper;->notifyStatusChanged(Lanet/channel/status/NetworkStatusHelper$NetworkStatus;)V
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_1

    goto :goto_4

    :catch_1
    move-exception v0

    new-array v1, v4, [Ljava/lang/Object;

    .line 187
    invoke-static {v6, v3, v8, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    :cond_9
    :goto_4
    return-void
.end method

.method static e()Landroid/net/NetworkInfo;
    .locals 2

    sget-object v0, Lanet/channel/status/b;->p:Landroid/net/ConnectivityManager;

    if-nez v0, :cond_0

    sget-object v0, Lanet/channel/status/b;->a:Landroid/content/Context;

    const-string v1, "connectivity"

    .line 278
    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/ConnectivityManager;

    sput-object v0, Lanet/channel/status/b;->p:Landroid/net/ConnectivityManager;

    :cond_0
    sget-object v0, Lanet/channel/status/b;->p:Landroid/net/ConnectivityManager;

    .line 280
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getActiveNetworkInfo()Landroid/net/NetworkInfo;

    move-result-object v0

    return-object v0
.end method

.method static f()Ljava/lang/String;
    .locals 7

    const/4 v0, 0x0

    :try_start_0
    const-string v1, "android.os.SystemProperties"

    .line 310
    invoke-static {v1}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v1

    const-string v2, "get"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Class;

    .line 311
    const-class v4, Ljava/lang/String;

    const/4 v5, 0x0

    aput-object v4, v3, v5

    invoke-virtual {v1, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v1

    sget-object v2, Lanet/channel/status/b;->m:[Ljava/lang/String;

    .line 312
    array-length v3, v2

    :goto_0
    if-ge v5, v3, :cond_1

    aget-object v4, v2, v5

    .line 313
    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-virtual {v1, v0, v4}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    .line 314
    invoke-static {v4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v6
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    if-nez v6, :cond_0

    return-object v4

    :cond_0
    add-int/lit8 v5, v5, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    return-object v0
.end method

.method static g()I
    .locals 1

    sget-object v0, Lanet/channel/status/b;->p:Landroid/net/ConnectivityManager;

    if-eqz v0, :cond_0

    sget-object v0, Lanet/channel/status/b;->p:Landroid/net/ConnectivityManager;

    .line 331
    invoke-virtual {v0}, Landroid/net/ConnectivityManager;->getRestrictBackgroundStatus()I

    move-result v0

    return v0

    :cond_0
    const/4 v0, -0x1

    return v0
.end method

.method private static h()V
    .locals 4

    .line 249
    :try_start_0
    invoke-static {}, Lanet/channel/AwcnConfig;->isCarrierInfoEnable()Z

    move-result v0

    if-nez v0, :cond_0

    return-void

    :cond_0
    const-string v0, "android.permission.READ_PHONE_STATE"

    .line 253
    invoke-static {v0}, Lanet/channel/status/b;->b(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1

    return-void

    :cond_1
    sget-object v0, Lanet/channel/status/b;->q:Landroid/telephony/TelephonyManager;

    if-nez v0, :cond_2

    sget-object v0, Lanet/channel/status/b;->a:Landroid/content/Context;

    const-string v1, "phone"

    .line 258
    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/TelephonyManager;

    sput-object v0, Lanet/channel/status/b;->q:Landroid/telephony/TelephonyManager;

    :cond_2
    sget-object v0, Lanet/channel/status/b;->q:Landroid/telephony/TelephonyManager;

    .line 260
    invoke-virtual {v0}, Landroid/telephony/TelephonyManager;->getSimOperator()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lanet/channel/status/b;->i:Ljava/lang/String;

    sget-object v0, Lanet/channel/status/b;->s:Landroid/telephony/SubscriptionManager;

    const/4 v1, 0x0

    if-nez v0, :cond_3

    sget-object v0, Lanet/channel/status/b;->a:Landroid/content/Context;

    .line 264
    invoke-static {v0}, Landroid/telephony/SubscriptionManager;->from(Landroid/content/Context;)Landroid/telephony/SubscriptionManager;

    move-result-object v0

    sput-object v0, Lanet/channel/status/b;->s:Landroid/telephony/SubscriptionManager;

    .line 265
    invoke-virtual {v0}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object v0

    const-string v2, "getDefaultDataSubscriptionInfo"

    new-array v3, v1, [Ljava/lang/Class;

    invoke-virtual {v0, v2, v3}, Ljava/lang/Class;->getDeclaredMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;

    move-result-object v0

    sput-object v0, Lanet/channel/status/b;->t:Ljava/lang/reflect/Method;

    :cond_3
    sget-object v0, Lanet/channel/status/b;->t:Ljava/lang/reflect/Method;

    if-eqz v0, :cond_4

    sget-object v2, Lanet/channel/status/b;->s:Landroid/telephony/SubscriptionManager;

    new-array v1, v1, [Ljava/lang/Object;

    .line 268
    invoke-virtual {v0, v2, v1}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/telephony/SubscriptionInfo;

    .line 269
    invoke-virtual {v0}, Landroid/telephony/SubscriptionInfo;->getCarrierName()Ljava/lang/CharSequence;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lanet/channel/status/b;->h:Ljava/lang/String;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_4
    return-void
.end method

.method private static i()Landroid/net/wifi/WifiInfo;
    .locals 5

    :try_start_0
    sget-object v0, Lanet/channel/status/b;->r:Landroid/net/wifi/WifiManager;

    if-nez v0, :cond_0

    sget-object v0, Lanet/channel/status/b;->a:Landroid/content/Context;

    const-string v1, "wifi"

    .line 287
    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/net/wifi/WifiManager;

    sput-object v0, Lanet/channel/status/b;->r:Landroid/net/wifi/WifiManager;

    :cond_0
    sget-object v0, Lanet/channel/status/b;->r:Landroid/net/wifi/WifiManager;

    .line 289
    invoke-virtual {v0}, Landroid/net/wifi/WifiManager;->getConnectionInfo()Landroid/net/wifi/WifiInfo;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    goto :goto_0

    :catchall_0
    move-exception v0

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/Object;

    const-string v2, "awcn.NetworkStatusMonitor"

    const-string v3, "getWifiInfo"

    const/4 v4, 0x0

    .line 291
    invoke-static {v2, v3, v4, v0, v1}, Lanet/channel/util/ALog;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;[Ljava/lang/Object;)V

    move-object v0, v4

    :goto_0
    return-object v0
.end method

.method private static j()Landroid/util/Pair;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Landroid/util/Pair<",
            "Ljava/lang/String;",
            "Ljava/lang/Integer;",
            ">;"
        }
    .end annotation

    :try_start_0
    const-string v0, "http.proxyHost"

    .line 298
    invoke-static {v0}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 299
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "http.proxyPort"

    .line 300
    invoke-static {v1}, Ljava/lang/System;->getProperty(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    .line 301
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    invoke-static {v0, v1}, Landroid/util/Pair;->create(Ljava/lang/Object;Ljava/lang/Object;)Landroid/util/Pair;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/NumberFormatException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method
