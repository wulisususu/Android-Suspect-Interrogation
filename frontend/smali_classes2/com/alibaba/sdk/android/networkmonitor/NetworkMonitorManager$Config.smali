.class public final Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
.super Ljava/lang/Object;
.source "NetworkMonitorManager.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = "Config"
.end annotation


# instance fields
.field a:I

.field a:Landroid/app/Application;

.field a:Ljava/lang/String;

.field a:Z

.field b:Ljava/lang/String;

.field c:Ljava/lang/String;

.field d:Ljava/lang/String;

.field e:Ljava/lang/String;

.field f:Ljava/lang/String;

.field g:Ljava/lang/String;

.field h:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:Z

    iput v0, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:I

    return-void
.end method


# virtual methods
.method public appId(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:Ljava/lang/String;

    return-object p0
.end method

.method public appKey(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->b:Ljava/lang/String;

    return-object p0
.end method

.method public appSecret(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->c:Ljava/lang/String;

    return-object p0
.end method

.method public appVersion(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->d:Ljava/lang/String;

    return-object p0
.end method

.method public channel(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->e:Ljava/lang/String;

    return-object p0
.end method

.method public context(Landroid/app/Application;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:Landroid/app/Application;

    return-object p0
.end method

.method public host(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->h:Ljava/lang/String;

    return-object p0
.end method

.method public rsaPublicKey(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->g:Ljava/lang/String;

    return-object p0
.end method

.method public setNoCollectionDataType(I)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    .locals 0

    iput p1, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:I

    return-object p0
.end method

.method public useHttp(Z)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    .locals 0

    iput-boolean p1, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->a:Z

    return-object p0
.end method

.method public userNick(Ljava/lang/String;)Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/networkmonitor/NetworkMonitorManager$Config;->f:Ljava/lang/String;

    return-object p0
.end method
