.class Lanet/channel/i;
.super Ljava/lang/Object;
.source "Taobao"

# interfaces
.implements Ljava/lang/Runnable;


# instance fields
.field final synthetic a:Lanet/channel/Session;

.field final synthetic b:Lanet/channel/SessionRequest$a;


# direct methods
.method constructor <init>(Lanet/channel/SessionRequest$a;Lanet/channel/Session;)V
    .locals 0

    iput-object p1, p0, Lanet/channel/i;->b:Lanet/channel/SessionRequest$a;

    iput-object p2, p0, Lanet/channel/i;->a:Lanet/channel/Session;

    .line 436
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 8

    :try_start_0
    iget-object v0, p0, Lanet/channel/i;->b:Lanet/channel/SessionRequest$a;

    .line 440
    iget-object v1, v0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    iget-object v0, p0, Lanet/channel/i;->b:Lanet/channel/SessionRequest$a;

    invoke-static {v0}, Lanet/channel/SessionRequest$a;->a(Lanet/channel/SessionRequest$a;)Landroid/content/Context;

    move-result-object v2

    iget-object v0, p0, Lanet/channel/i;->a:Lanet/channel/Session;

    invoke-virtual {v0}, Lanet/channel/Session;->getConnType()Lanet/channel/entity/ConnType;

    move-result-object v0

    invoke-virtual {v0}, Lanet/channel/entity/ConnType;->getType()I

    move-result v3

    iget-object v0, p0, Lanet/channel/i;->b:Lanet/channel/SessionRequest$a;

    iget-object v0, v0, Lanet/channel/SessionRequest$a;->b:Lanet/channel/SessionRequest;

    .line 1060
    iget-object v0, v0, Lanet/channel/SessionRequest;->a:Lanet/channel/SessionCenter;

    .line 440
    iget-object v0, v0, Lanet/channel/SessionCenter;->c:Ljava/lang/String;

    invoke-static {v0}, Lanet/channel/util/i;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    const-wide/16 v6, 0x0

    invoke-virtual/range {v1 .. v7}, Lanet/channel/SessionRequest;->a(Landroid/content/Context;ILjava/lang/String;Lanet/channel/SessionGetCallback;J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
