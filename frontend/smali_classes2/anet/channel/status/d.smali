.class Lanet/channel/status/d;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lanet/channel/status/NetworkStatusMonitor$2;


# direct methods
.method constructor <init>(Lanet/channel/status/NetworkStatusMonitor$2;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/status/d;->a:Lanet/channel/status/NetworkStatusMonitor$2;

    .line 122
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 0

    .line 125
    invoke-static {}, Lanet/channel/status/b;->d()V

    return-void
.end method
