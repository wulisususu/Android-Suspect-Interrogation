.class public Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x9
    name = "Builder"
.end annotation


# instance fields
.field private accsAppConnectHost:Ljava/lang/String;

.field private accsSilentConnectHost:Ljava/lang/String;

.field private appKey:Ljava/lang/String;

.field private appSecret:Ljava/lang/String;

.field private application:Landroid/app/Application;

.field private disableChannelProcess:Z

.field private disableChannelProcessHeartbeat:Z

.field private disableForegroundCheck:Z

.field private loopInterval:J

.field private loopStartChannel:Z

.field private mLargeIconDownloadListener:Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;

.field private pushHost:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 4

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->appKey:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->appSecret:Ljava/lang/String;

    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->disableChannelProcess:Z

    const/4 v2, 0x1

    iput-boolean v2, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->disableChannelProcessHeartbeat:Z

    iput-boolean v1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->loopStartChannel:Z

    const-wide/32 v2, 0x493e0

    iput-wide v2, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->loopInterval:J

    iput-boolean v1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->disableForegroundCheck:Z

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->pushHost:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->accsAppConnectHost:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->accsSilentConnectHost:Ljava/lang/String;

    return-void
.end method

.method static synthetic access$000(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Landroid/app/Application;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->application:Landroid/app/Application;

    return-object p0
.end method

.method static synthetic access$100(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->appKey:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$1000(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->accsSilentConnectHost:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$1100(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->mLargeIconDownloadListener:Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;

    return-object p0
.end method

.method static synthetic access$200(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->appSecret:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$300(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->disableChannelProcess:Z

    return p0
.end method

.method static synthetic access$400(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->loopStartChannel:Z

    return p0
.end method

.method static synthetic access$500(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)J
    .locals 2

    iget-wide v0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->loopInterval:J

    return-wide v0
.end method

.method static synthetic access$600(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->disableForegroundCheck:Z

    return p0
.end method

.method static synthetic access$700(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Z
    .locals 0

    iget-boolean p0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->disableChannelProcessHeartbeat:Z

    return p0
.end method

.method static synthetic access$800(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->pushHost:Ljava/lang/String;

    return-object p0
.end method

.method static synthetic access$900(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)Ljava/lang/String;
    .locals 0

    iget-object p0, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->accsAppConnectHost:Ljava/lang/String;

    return-object p0
.end method


# virtual methods
.method public accsAppConnectHost(Ljava/lang/String;)Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->accsAppConnectHost:Ljava/lang/String;

    return-object p0
.end method

.method public accsSilentConnectHost(Ljava/lang/String;)Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->accsSilentConnectHost:Ljava/lang/String;

    return-object p0
.end method

.method public appKey(Ljava/lang/String;)Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->appKey:Ljava/lang/String;

    return-object p0
.end method

.method public appSecret(Ljava/lang/String;)Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->appSecret:Ljava/lang/String;

    return-object p0
.end method

.method public application(Landroid/app/Application;)Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->application:Landroid/app/Application;

    return-object p0
.end method

.method public build()Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;
    .locals 1

    new-instance v0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;

    invoke-direct {v0, p0}, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig;-><init>(Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;)V

    return-object v0
.end method

.method public disableChannelProcess(Z)Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    iput-boolean p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->disableChannelProcess:Z

    return-object p0
.end method

.method public disableChannelProcessHeartbeat(Z)Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    .locals 0
    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    iput-boolean p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->disableChannelProcessHeartbeat:Z

    return-object p0
.end method

.method public disableForegroundCheck(Z)Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->disableForegroundCheck:Z

    return-object p0
.end method

.method public largeIconDownloadListener(Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;)Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->mLargeIconDownloadListener:Lcom/alibaba/sdk/android/push/util/DownloadUtil$OnLargeIconDownloadListener;

    return-object p0
.end method

.method public loopInterval(J)Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    .locals 0

    iput-wide p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->loopInterval:J

    return-object p0
.end method

.method public loopStartChannel(Z)Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    .locals 0

    iput-boolean p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->loopStartChannel:Z

    return-object p0
.end method

.method public pushHost(Ljava/lang/String;)Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/push/noonesdk/PushInitConfig$Builder;->pushHost:Ljava/lang/String;

    return-object p0
.end method
