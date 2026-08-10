.class Lcom/ta/utdid2/device/a$1;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/ta/utdid2/device/a;->f()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Landroid/content/Context;

.field final synthetic b:Lcom/ta/utdid2/device/a;


# direct methods
.method constructor <init>(Lcom/ta/utdid2/device/a;Landroid/content/Context;)V
    .locals 0

    iput-object p1, p0, Lcom/ta/utdid2/device/a$1;->b:Lcom/ta/utdid2/device/a;

    iput-object p2, p0, Lcom/ta/utdid2/device/a$1;->a:Landroid/content/Context;

    .line 91
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 2

    .line 96
    :try_start_0
    invoke-static {}, Lcom/ta/utdid2/device/a;->b()J

    move-result-wide v0

    invoke-static {v0, v1}, Ljava/lang/Thread;->sleep(J)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    iget-object v0, p0, Lcom/ta/utdid2/device/a$1;->a:Landroid/content/Context;

    .line 101
    invoke-static {v0}, Lcom/ta/a/b/e;->a(Landroid/content/Context;)Z

    move-result v0

    if-nez v0, :cond_0

    const-string v0, "unable upload!"

    .line 103
    filled-new-array {v0}, [Ljava/lang/Object;

    move-result-object v0

    const-string v1, ""

    invoke-static {v1, v0}, Lcom/ta/a/c/f;->a(Ljava/lang/String;[Ljava/lang/Object;)V

    return-void

    .line 108
    :cond_0
    new-instance v0, Lcom/ta/a/b/h;

    iget-object v1, p0, Lcom/ta/utdid2/device/a$1;->a:Landroid/content/Context;

    invoke-direct {v0, v1}, Lcom/ta/a/b/h;-><init>(Landroid/content/Context;)V

    invoke-virtual {v0}, Lcom/ta/a/b/h;->run()V

    return-void
.end method
