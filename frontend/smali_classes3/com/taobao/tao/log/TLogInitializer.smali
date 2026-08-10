.class public Lcom/taobao/tao/log/TLogInitializer;
.super Ljava/lang/Object;
.source "TLogInitializer.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/taobao/tao/log/TLogInitializer$a;
    }
.end annotation


# static fields
.field public static final INIT_END:I = 0x2

.field public static final INIT_ING:I = 0x1

.field public static final INIT_NO:I


# instance fields
.field private volatile a:I

.field private a:J

.field private a:Lcom/taobao/tao/log/message/MessageSender;

.field private a:Lcom/taobao/tao/log/monitor/TLogMonitor;

.field private a:Lcom/taobao/tao/log/upload/LogUploader;

.field private a:Ljava/io/File;

.field private a:Ljava/lang/String;

.field private a:Z

.field public accsServiceId:Ljava/lang/String;

.field public accsTag:Ljava/lang/String;

.field private appId:Ljava/lang/String;

.field private appVersion:Ljava/lang/String;

.field private application:Landroid/app/Application;

.field private b:I

.field private b:Ljava/lang/String;

.field private b:Z

.field private c:Ljava/lang/String;

.field private c:Z

.field private context:Landroid/content/Context;

.field private d:Ljava/lang/String;

.field private d:Z

.field private e:Ljava/lang/String;

.field private e:Z

.field private f:Z

.field private logLevel:Lcom/taobao/tao/log/LogLevel;

.field public messageHostName:Ljava/lang/String;

.field public ossBucketName:Ljava/lang/String;

.field private ttid:Ljava/lang/String;

.field private userNick:Ljava/lang/String;

.field private utdid:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 3

    .line 101
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Z

    const-string v1, ""

    iput-object v1, p0, Lcom/taobao/tao/log/TLogInitializer;->appVersion:Ljava/lang/String;

    const-string v2, "bbbbbbbbbbbbbbbbb"

    iput-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->utdid:Ljava/lang/String;

    const-string v2, "-"

    iput-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->ttid:Ljava/lang/String;

    iput-object v1, p0, Lcom/taobao/tao/log/TLogInitializer;->userNick:Ljava/lang/String;

    .line 60
    sget-object v2, Lcom/taobao/tao/log/LogLevel;->I:Lcom/taobao/tao/log/LogLevel;

    iput-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->logLevel:Lcom/taobao/tao/log/LogLevel;

    iput-boolean v0, p0, Lcom/taobao/tao/log/TLogInitializer;->b:Z

    iput-boolean v0, p0, Lcom/taobao/tao/log/TLogInitializer;->c:Z

    iput v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:I

    const-string v2, "ha-remote-log"

    iput-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->ossBucketName:Ljava/lang/String;

    const-string v2, "adash.emas-ha.cn"

    iput-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->messageHostName:Ljava/lang/String;

    const-string v2, "emas-ha"

    iput-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->accsServiceId:Ljava/lang/String;

    const/4 v2, 0x0

    iput-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->accsTag:Ljava/lang/String;

    iput-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Lcom/taobao/tao/log/upload/LogUploader;

    iput-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Lcom/taobao/tao/log/message/MessageSender;

    iput-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Lcom/taobao/tao/log/monitor/TLogMonitor;

    iput-boolean v0, p0, Lcom/taobao/tao/log/TLogInitializer;->d:Z

    iput-object v1, p0, Lcom/taobao/tao/log/TLogInitializer;->d:Ljava/lang/String;

    iput-boolean v0, p0, Lcom/taobao/tao/log/TLogInitializer;->e:Z

    const-wide/32 v1, 0x500000

    iput-wide v1, p0, Lcom/taobao/tao/log/TLogInitializer;->a:J

    iput-boolean v0, p0, Lcom/taobao/tao/log/TLogInitializer;->f:Z

    iput v0, p0, Lcom/taobao/tao/log/TLogInitializer;->b:I

    return-void
.end method

.method synthetic constructor <init>(Lcom/taobao/tao/log/TLogInitializer$1;)V
    .locals 0

    .line 45
    invoke-direct {p0}, Lcom/taobao/tao/log/TLogInitializer;-><init>()V

    return-void
.end method

.method private a()V
    .locals 3

    .line 191
    invoke-static {}, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->getInstance()Lcom/taobao/tao/log/godeye/GodeyeInitializer;

    move-result-object v0

    new-instance v1, Lcom/taobao/tao/log/task/n;

    invoke-direct {v1}, Lcom/taobao/tao/log/task/n;-><init>()V

    const-string v2, "RDWP_METHOD_TRACE_DUMP"

    invoke-virtual {v0, v2, v1}, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->registGodEyeReponse(Ljava/lang/String;Lcom/taobao/tao/log/godeye/core/GodEyeReponse;)V

    .line 192
    invoke-static {}, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->getInstance()Lcom/taobao/tao/log/godeye/GodeyeInitializer;

    move-result-object v0

    new-instance v1, Lcom/taobao/tao/log/task/g;

    invoke-direct {v1}, Lcom/taobao/tao/log/task/g;-><init>()V

    const-string v2, "RDWP_HEAP_DUMP"

    invoke-virtual {v0, v2, v1}, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->registGodEyeReponse(Ljava/lang/String;Lcom/taobao/tao/log/godeye/core/GodEyeReponse;)V

    .line 194
    new-instance v0, Lcom/taobao/tao/log/godeye/GodeyeConfig;

    invoke-direct {v0}, Lcom/taobao/tao/log/godeye/GodeyeConfig;-><init>()V

    .line 195
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->getAppVersion()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/taobao/tao/log/godeye/GodeyeConfig;->appVersion:Ljava/lang/String;

    const/4 v1, 0x0

    .line 196
    iput-object v1, v0, Lcom/taobao/tao/log/godeye/GodeyeConfig;->packageTag:Ljava/lang/String;

    .line 197
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getUTDID()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/taobao/tao/log/godeye/GodeyeConfig;->utdid:Ljava/lang/String;

    .line 198
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->getAppId()Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lcom/taobao/tao/log/godeye/GodeyeConfig;->appId:Ljava/lang/String;

    .line 199
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v1

    invoke-virtual {v1}, Lcom/taobao/tao/log/TLogInitializer;->getApplication()Landroid/app/Application;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 201
    invoke-static {}, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->getInstance()Lcom/taobao/tao/log/godeye/GodeyeInitializer;

    move-result-object v1

    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v2

    invoke-virtual {v2}, Lcom/taobao/tao/log/TLogInitializer;->getApplication()Landroid/app/Application;

    move-result-object v2

    invoke-virtual {v1, v2, v0}, Lcom/taobao/tao/log/godeye/GodeyeInitializer;->init(Landroid/app/Application;Lcom/taobao/tao/log/godeye/GodeyeConfig;)V

    :cond_0
    return-void
.end method

.method private a(Landroid/content/Context;)Z
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/tao/log/TLogInitializer;->b:Z

    if-eqz v0, :cond_0

    iget-boolean p1, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Z

    return p1

    :cond_0
    const/4 v0, 0x0

    .line 534
    :try_start_0
    invoke-virtual {p1}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object p1

    .line 535
    iget p1, p1, Landroid/content/pm/ApplicationInfo;->flags:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    and-int/lit8 p1, p1, 0x2

    if-eqz p1, :cond_1

    const/4 v0, 0x1

    :catch_0
    :cond_1
    return v0
.end method

.method public static getInstance()Lcom/taobao/tao/log/TLogInitializer;
    .locals 1

    .line 109
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer$a;->a()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    return-object v0
.end method

.method public static getTLogControler()Lcom/taobao/tao/log/ITLogController;
    .locals 1

    .line 446
    invoke-static {}, Lcom/taobao/tao/log/TLogController;->getInstance()Lcom/taobao/tao/log/TLogController;

    move-result-object v0

    return-object v0
.end method

.method public static getUTDID()Ljava/lang/String;
    .locals 1

    .line 511
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    iget-object v0, v0, Lcom/taobao/tao/log/TLogInitializer;->utdid:Ljava/lang/String;

    return-object v0
.end method


# virtual methods
.method public builder(Landroid/content/Context;Lcom/taobao/tao/log/LogLevel;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 1

    iget v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:I

    if-eqz v0, :cond_0

    return-object p0

    .line 210
    :cond_0
    invoke-direct {p0, p1}, Lcom/taobao/tao/log/TLogInitializer;->a(Landroid/content/Context;)Z

    move-result v0

    iput-boolean v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Z

    if-eqz p2, :cond_1

    iput-object p2, p0, Lcom/taobao/tao/log/TLogInitializer;->logLevel:Lcom/taobao/tao/log/LogLevel;

    :cond_1
    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->context:Landroid/content/Context;

    iput-object p5, p0, Lcom/taobao/tao/log/TLogInitializer;->b:Ljava/lang/String;

    iput-object p6, p0, Lcom/taobao/tao/log/TLogInitializer;->appVersion:Ljava/lang/String;

    .line 218
    invoke-static {p4}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p2

    if-eqz p2, :cond_2

    const-string p4, "TAOBAO"

    :cond_2
    iput-object p4, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Ljava/lang/String;

    const-string p2, "[:*?_<>|\"\\\\/]"

    const-string p5, "-"

    .line 222
    invoke-virtual {p4, p2, p5}, Ljava/lang/String;->replaceAll(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p2

    iput-object p2, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Ljava/lang/String;

    .line 224
    invoke-static {p3}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result p2

    if-eqz p2, :cond_3

    const-string p3, "logs"

    :cond_3
    iget-boolean p2, p0, Lcom/taobao/tao/log/TLogInitializer;->e:Z

    const/4 p4, 0x0

    if-eqz p2, :cond_4

    .line 226
    invoke-virtual {p1, p3, p4}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Ljava/io/File;

    goto :goto_1

    :cond_4
    const-string p2, "android.permission.WRITE_EXTERNAL_STORAGE"

    .line 230
    invoke-virtual {p1, p2}, Landroid/content/Context;->checkSelfPermission(Ljava/lang/String;)I

    move-result p2

    if-nez p2, :cond_5

    .line 232
    :try_start_0
    invoke-virtual {p1, p3}, Landroid/content/Context;->getExternalFilesDir(Ljava/lang/String;)Ljava/io/File;

    move-result-object p2
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p2

    .line 234
    invoke-virtual {p2}, Ljava/lang/Exception;->printStackTrace()V

    :cond_5
    const/4 p2, 0x0

    :goto_0
    if-nez p2, :cond_6

    .line 237
    invoke-virtual {p1, p3, p4}, Landroid/content/Context;->getDir(Ljava/lang/String;I)Ljava/io/File;

    move-result-object p2

    :cond_6
    iput-object p2, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Ljava/io/File;

    :goto_1
    return-object p0
.end method

.method public changeConfigHost(Ljava/lang/String;)V
    .locals 2

    iget v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 543
    invoke-static {p1}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v0

    if-nez v0, :cond_1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->b:Ljava/lang/String;

    const-string v1, "tlog"

    .line 544
    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/settingservice/EmasSettingService;->getInstance(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/EmasSettingService;

    move-result-object v0

    .line 545
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/EmasSettingService;->setHost(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/Initializer;

    goto :goto_0

    :cond_0
    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->e:Ljava/lang/String;

    :cond_1
    :goto_0
    return-void
.end method

.method public changeRsaPublishKey(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 1

    if-eqz p1, :cond_0

    .line 297
    invoke-static {}, Lcom/taobao/android/tlog/protocol/TLogSecret;->getInstance()Lcom/taobao/android/tlog/protocol/TLogSecret;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/taobao/android/tlog/protocol/TLogSecret;->setRsapublickey(Ljava/lang/String;)V

    :cond_0
    return-object p0
.end method

.method public getAppId()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->appId:Ljava/lang/String;

    if-nez v0, :cond_0

    .line 497
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/taobao/tao/log/TLogInitializer;->b:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "@android"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->appId:Ljava/lang/String;

    :cond_0
    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->appId:Ljava/lang/String;

    return-object v0
.end method

.method public getAppVersion()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->appVersion:Ljava/lang/String;

    return-object v0
.end method

.method public getAppkey()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->b:Ljava/lang/String;

    return-object v0
.end method

.method public getApplication()Landroid/app/Application;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->application:Landroid/app/Application;

    return-object v0
.end method

.method public getAuthCode()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->d:Ljava/lang/String;

    return-object v0
.end method

.method public getContext()Landroid/content/Context;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->context:Landroid/content/Context;

    return-object v0
.end method

.method public getFileDir()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Ljava/io/File;

    .line 520
    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public getInitState()I
    .locals 1

    iget v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:I

    return v0
.end method

.method public getLogUploader()Lcom/taobao/tao/log/upload/LogUploader;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Lcom/taobao/tao/log/upload/LogUploader;

    return-object v0
.end method

.method public getMessageSender()Lcom/taobao/tao/log/message/MessageSender;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Lcom/taobao/tao/log/message/MessageSender;

    return-object v0
.end method

.method public getNameprefix()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Ljava/lang/String;

    return-object v0
.end method

.method public getNoCollectionDataType()I
    .locals 1

    iget v0, p0, Lcom/taobao/tao/log/TLogInitializer;->b:I

    return v0
.end method

.method public getSecurityKey()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->c:Ljava/lang/String;

    return-object v0
.end method

.method public getTtid()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->ttid:Ljava/lang/String;

    return-object v0
.end method

.method public getUserNick()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->userNick:Ljava/lang/String;

    return-object v0
.end method

.method public gettLogMonitor()Lcom/taobao/tao/log/monitor/TLogMonitor;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Lcom/taobao/tao/log/monitor/TLogMonitor;

    if-nez v0, :cond_0

    .line 473
    new-instance v0, Lcom/taobao/tao/log/monitor/DefaultTLogMonitorImpl;

    invoke-direct {v0}, Lcom/taobao/tao/log/monitor/DefaultTLogMonitorImpl;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Lcom/taobao/tao/log/monitor/TLogMonitor;

    :cond_0
    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Lcom/taobao/tao/log/monitor/TLogMonitor;

    return-object v0
.end method

.method public init()Lcom/taobao/tao/log/TLogInitializer;
    .locals 12

    const-string v0, "tlog_module"

    const-string v1, "tlog_level"

    const-string v2, "tlog_version"

    iget v3, p0, Lcom/taobao/tao/log/TLogInitializer;->a:I

    if-eqz v3, :cond_0

    return-object p0

    :cond_0
    const/4 v3, 0x1

    iput v3, p0, Lcom/taobao/tao/log/TLogInitializer;->a:I

    const/4 v4, 0x0

    :try_start_0
    iget-object v5, p0, Lcom/taobao/tao/log/TLogInitializer;->context:Landroid/content/Context;

    .line 123
    invoke-static {v5}, Landroid/preference/PreferenceManager;->getDefaultSharedPreferences(Landroid/content/Context;)Landroid/content/SharedPreferences;

    move-result-object v5

    .line 124
    invoke-interface {v5, v2}, Landroid/content/SharedPreferences;->contains(Ljava/lang/String;)Z

    move-result v6

    const/4 v7, 0x0

    if-eqz v6, :cond_2

    .line 126
    invoke-interface {v5, v2, v7}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_1

    iget-object v6, p0, Lcom/taobao/tao/log/TLogInitializer;->appVersion:Ljava/lang/String;

    .line 127
    invoke-virtual {v2, v6}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v2

    if-eqz v2, :cond_1

    iput-boolean v4, p0, Lcom/taobao/tao/log/TLogInitializer;->d:Z

    goto :goto_0

    :cond_1
    iput-boolean v3, p0, Lcom/taobao/tao/log/TLogInitializer;->d:Z

    goto :goto_0

    :cond_2
    iput-boolean v3, p0, Lcom/taobao/tao/log/TLogInitializer;->d:Z

    .line 136
    :goto_0
    invoke-interface {v5, v1}, Landroid/content/SharedPreferences;->contains(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    iget-boolean v2, p0, Lcom/taobao/tao/log/TLogInitializer;->d:Z

    if-nez v2, :cond_3

    const-string v2, "INFO"

    .line 137
    invoke-interface {v5, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    .line 138
    invoke-static {v1}, Lcom/taobao/tao/log/TLogUtils;->convertLogLevel(Ljava/lang/String;)Lcom/taobao/tao/log/LogLevel;

    move-result-object v1

    iput-object v1, p0, Lcom/taobao/tao/log/TLogInitializer;->logLevel:Lcom/taobao/tao/log/LogLevel;

    .line 139
    invoke-static {}, Lcom/taobao/tao/log/TLogController;->getInstance()Lcom/taobao/tao/log/TLogController;

    move-result-object v1

    iget-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->logLevel:Lcom/taobao/tao/log/LogLevel;

    invoke-virtual {v1, v2}, Lcom/taobao/tao/log/TLogController;->updateLogLevel(Lcom/taobao/tao/log/LogLevel;)V

    .line 142
    :cond_3
    invoke-interface {v5, v0}, Landroid/content/SharedPreferences;->contains(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    iget-boolean v1, p0, Lcom/taobao/tao/log/TLogInitializer;->d:Z

    if-nez v1, :cond_4

    .line 143
    invoke-interface {v5, v0, v7}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    .line 144
    invoke-static {v0}, Lcom/taobao/tao/log/TLogUtils;->makeModule(Ljava/lang/String;)Ljava/util/Map;

    move-result-object v0

    .line 145
    invoke-static {}, Lcom/taobao/tao/log/TLogController;->getInstance()Lcom/taobao/tao/log/TLogController;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/taobao/tao/log/TLogController;->addModuleFilter(Ljava/util/Map;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    .line 148
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 151
    :cond_4
    :goto_1
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lcom/taobao/tao/log/TLogInitializer;->context:Landroid/content/Context;

    invoke-virtual {v1}, Landroid/content/Context;->getFilesDir()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v1, Ljava/io/File;->separator:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, "logs"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v6

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->logLevel:Lcom/taobao/tao/log/LogLevel;

    .line 152
    invoke-virtual {v0}, Lcom/taobao/tao/log/LogLevel;->getIndex()I

    move-result v5

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Ljava/io/File;

    invoke-virtual {v0}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v7

    iget-object v8, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Ljava/lang/String;

    iget-object v9, p0, Lcom/taobao/tao/log/TLogInitializer;->b:Ljava/lang/String;

    iget-wide v10, p0, Lcom/taobao/tao/log/TLogInitializer;->a:J

    invoke-static/range {v5 .. v11}, Lcom/taobao/tao/log/TLogNative;->appenderOpen(ILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;J)V

    .line 153
    invoke-static {}, Lcom/taobao/tao/log/TLogNative;->isSoOpen()Z

    move-result v0

    if-eqz v0, :cond_5

    .line 155
    :try_start_1
    invoke-static {v4}, Lcom/taobao/tao/log/TLogNative;->setConsoleLogOpen(Z)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    goto :goto_2

    :catchall_0
    move-exception v0

    .line 157
    invoke-virtual {v0}, Ljava/lang/Throwable;->printStackTrace()V

    .line 160
    :cond_5
    :goto_2
    invoke-static {}, Lcom/taobao/tao/log/TLogController;->getInstance()Lcom/taobao/tao/log/TLogController;

    move-result-object v0

    iget-object v1, p0, Lcom/taobao/tao/log/TLogInitializer;->logLevel:Lcom/taobao/tao/log/LogLevel;

    invoke-virtual {v0, v1}, Lcom/taobao/tao/log/TLogController;->updateLogLevel(Lcom/taobao/tao/log/LogLevel;)V

    .line 161
    invoke-static {}, Lcom/taobao/tao/log/task/f;->a()Lcom/taobao/tao/log/task/f;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/task/f;->d()V

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->b:Ljava/lang/String;

    const-string v1, "tlog"

    .line 163
    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/settingservice/EmasSettingService;->getInstance(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/EmasSettingService;

    move-result-object v0

    .line 164
    invoke-virtual {p0}, Lcom/taobao/tao/log/TLogInitializer;->getSecurityKey()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/alibaba/sdk/android/settingservice/EmasSettingService;->setAppSecret(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/Initializer;

    move-result-object v0

    iget-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->context:Landroid/content/Context;

    .line 165
    invoke-interface {v0, v2}, Lcom/alibaba/sdk/android/settingservice/Initializer;->setContext(Landroid/content/Context;)Lcom/alibaba/sdk/android/settingservice/Initializer;

    move-result-object v0

    const-string v2, "1.1.8.0-open"

    .line 166
    invoke-interface {v0, v2}, Lcom/alibaba/sdk/android/settingservice/Initializer;->setSdkVersion(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/Initializer;

    move-result-object v0

    iget-boolean v2, p0, Lcom/taobao/tao/log/TLogInitializer;->f:Z

    if-eqz v2, :cond_6

    .line 168
    invoke-interface {v0, v3}, Lcom/alibaba/sdk/android/settingservice/Initializer;->openHttp(Z)Lcom/alibaba/sdk/android/settingservice/Initializer;

    :cond_6
    iget-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->e:Ljava/lang/String;

    .line 170
    invoke-static {v2}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v2

    if-nez v2, :cond_7

    iget-object v2, p0, Lcom/taobao/tao/log/TLogInitializer;->e:Ljava/lang/String;

    .line 171
    invoke-interface {v0, v2}, Lcom/alibaba/sdk/android/settingservice/Initializer;->setHost(Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/Initializer;

    :cond_7
    const/4 v0, 0x2

    iput v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:I

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->logLevel:Lcom/taobao/tao/log/LogLevel;

    .line 176
    invoke-virtual {v0}, Lcom/taobao/tao/log/LogLevel;->getName()Ljava/lang/String;

    move-result-object v0

    iget-wide v2, p0, Lcom/taobao/tao/log/TLogInitializer;->a:J

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    filled-new-array {v0, v2}, [Ljava/lang/Object;

    move-result-object v0

    const-string v2, "tlog init end! logLevel=%s, logMaxSize=%d"

    invoke-static {v2, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0

    const-string v2, "init"

    invoke-static {v1, v2, v0}, Lcom/taobao/tao/log/TLog;->loge(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    iget-boolean v0, p0, Lcom/taobao/tao/log/TLogInitializer;->c:Z

    if-nez v0, :cond_8

    .line 178
    invoke-static {}, Lcom/taobao/tao/log/TLogController;->getInstance()Lcom/taobao/tao/log/TLogController;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogController;->updateAsyncConfig()V

    .line 182
    :cond_8
    invoke-direct {p0}, Lcom/taobao/tao/log/TLogInitializer;->a()V

    return-object p0
.end method

.method public isDebugable()Z
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Z

    return v0
.end method

.method public isInitSync()Z
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/tao/log/TLogInitializer;->c:Z

    return v0
.end method

.method public openHttp(Z)V
    .locals 2

    iget v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->b:Ljava/lang/String;

    const-string v1, "tlog"

    .line 554
    invoke-static {v0, v1}, Lcom/alibaba/sdk/android/settingservice/EmasSettingService;->getInstance(Ljava/lang/String;Ljava/lang/String;)Lcom/alibaba/sdk/android/settingservice/EmasSettingService;

    move-result-object v0

    .line 555
    invoke-virtual {v0, p1}, Lcom/alibaba/sdk/android/settingservice/EmasSettingService;->openHttp(Z)Lcom/alibaba/sdk/android/settingservice/Initializer;

    goto :goto_0

    :cond_0
    iput-boolean p1, p0, Lcom/taobao/tao/log/TLogInitializer;->f:Z

    :goto_0
    return-void
.end method

.method public setAppId(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->appId:Ljava/lang/String;

    return-object p0
.end method

.method public setAppVersion(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->appVersion:Ljava/lang/String;

    return-object p0
.end method

.method public setApplication(Landroid/app/Application;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->application:Landroid/app/Application;

    return-object p0
.end method

.method public setAuthCode(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->d:Ljava/lang/String;

    return-object p0
.end method

.method public setDebugMode(Z)Lcom/taobao/tao/log/TLogInitializer;
    .locals 1

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/tao/log/TLogInitializer;->b:Z

    iput-boolean p1, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Z

    return-object p0
.end method

.method public setInitSync(Z)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput-boolean p1, p0, Lcom/taobao/tao/log/TLogInitializer;->c:Z

    return-object p0
.end method

.method public setLogFileMaxSize(J)Lcom/taobao/tao/log/TLogInitializer;
    .locals 2

    const-wide/32 v0, 0x100000

    mul-long/2addr p1, v0

    iput-wide p1, p0, Lcom/taobao/tao/log/TLogInitializer;->a:J

    return-object p0
.end method

.method public setLogUploader(Lcom/taobao/tao/log/upload/LogUploader;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Lcom/taobao/tao/log/upload/LogUploader;

    return-object p0
.end method

.method public setMessageSender(Lcom/taobao/tao/log/message/MessageSender;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 1

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Lcom/taobao/tao/log/message/MessageSender;

    if-eqz p1, :cond_0

    .line 321
    new-instance p1, Lcom/taobao/tao/log/message/MessageInfo;

    invoke-direct {p1}, Lcom/taobao/tao/log/message/MessageInfo;-><init>()V

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->context:Landroid/content/Context;

    .line 322
    iput-object v0, p1, Lcom/taobao/tao/log/message/MessageInfo;->context:Landroid/content/Context;

    .line 323
    invoke-static {}, Lcom/taobao/tao/log/TLogInitializer;->getInstance()Lcom/taobao/tao/log/TLogInitializer;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/TLogInitializer;->getAppkey()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p1, Lcom/taobao/tao/log/message/MessageInfo;->appKey:Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->accsServiceId:Ljava/lang/String;

    .line 324
    iput-object v0, p1, Lcom/taobao/tao/log/message/MessageInfo;->accsServiceId:Ljava/lang/String;

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Lcom/taobao/tao/log/message/MessageSender;

    .line 325
    invoke-interface {v0, p1}, Lcom/taobao/tao/log/message/MessageSender;->init(Lcom/taobao/tao/log/message/MessageInfo;)V

    .line 328
    invoke-static {}, Lcom/taobao/tao/log/task/p;->execute()V

    .line 331
    invoke-static {}, Lcom/taobao/tao/log/task/PullTask;->getInstance()Lcom/taobao/tao/log/task/PullTask;

    move-result-object p1

    invoke-virtual {p1}, Lcom/taobao/tao/log/task/PullTask;->start()V

    :cond_0
    return-object p0
.end method

.method public setNoCollectionDataType(I)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput p1, p0, Lcom/taobao/tao/log/TLogInitializer;->b:I

    return-object p0
.end method

.method public setSecurityKey(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->c:Ljava/lang/String;

    return-object p0
.end method

.method public setTTid(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->ttid:Ljava/lang/String;

    return-object p0
.end method

.method public setUserNick(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->userNick:Ljava/lang/String;

    return-object p0
.end method

.method public setUtdid(Ljava/lang/String;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->utdid:Ljava/lang/String;

    return-object p0
.end method

.method public settLogMonitor(Lcom/taobao/tao/log/monitor/TLogMonitor;)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->a:Lcom/taobao/tao/log/monitor/TLogMonitor;

    return-object p0
.end method

.method public startUpSampling(Ljava/lang/Integer;)V
    .locals 0

    .line 437
    invoke-static {p1}, Lcom/taobao/tao/log/task/p;->a(Ljava/lang/Integer;)V

    return-void
.end method

.method public updateLogLevel(Ljava/lang/String;)V
    .locals 1

    .line 418
    :try_start_0
    invoke-static {p1}, Lcom/taobao/tao/log/TLogUtils;->convertLogLevel(Ljava/lang/String;)Lcom/taobao/tao/log/LogLevel;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->logLevel:Lcom/taobao/tao/log/LogLevel;

    .line 419
    invoke-static {}, Lcom/taobao/tao/log/TLogController;->getInstance()Lcom/taobao/tao/log/TLogController;

    move-result-object p1

    iget-object v0, p0, Lcom/taobao/tao/log/TLogInitializer;->logLevel:Lcom/taobao/tao/log/LogLevel;

    invoke-virtual {p1, v0}, Lcom/taobao/tao/log/TLogController;->setLogLevel(Lcom/taobao/tao/log/LogLevel;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 421
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method

.method public updateUserNick(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/TLogInitializer;->userNick:Ljava/lang/String;

    .line 456
    invoke-static {}, Lcom/taobao/tao/log/task/q;->execute()V

    return-void
.end method

.method public uploadTlog(Ljava/lang/String;)V
    .locals 2

    iget v0, p0, Lcom/taobao/tao/log/TLogInitializer;->a:I

    const/4 v1, 0x2

    if-ne v0, v1, :cond_0

    .line 563
    invoke-static {}, Lcom/taobao/tao/log/upload/FileUploadHandler;->getInstance()Lcom/taobao/tao/log/upload/FileUploadHandler;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/taobao/tao/log/upload/FileUploadHandler;->sendPositiveMsg(Ljava/lang/String;)V

    :cond_0
    return-void
.end method

.method public useDataStoreLog(Z)Lcom/taobao/tao/log/TLogInitializer;
    .locals 0

    iput-boolean p1, p0, Lcom/taobao/tao/log/TLogInitializer;->e:Z

    return-object p0
.end method
