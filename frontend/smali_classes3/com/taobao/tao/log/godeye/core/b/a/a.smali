.class public Lcom/taobao/tao/log/godeye/core/b/a/a;
.super Lcom/taobao/tao/log/godeye/core/b/a/b;
.source "BuildInPlugin.java"


# direct methods
.method public constructor <init>(Lcom/taobao/tao/log/godeye/core/b/a/b$a;)V
    .locals 0

    .line 12
    invoke-direct {p0, p1}, Lcom/taobao/tao/log/godeye/core/b/a/b;-><init>(Lcom/taobao/tao/log/godeye/core/b/a/b$a;)V

    return-void
.end method


# virtual methods
.method public execute()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/lang/Exception;
        }
    .end annotation

    .line 17
    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/b/a/a;->a:Lcom/taobao/tao/log/godeye/core/b/a/b$a;

    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/core/b/a/b$a;->c()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Class;->forName(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v0

    .line 18
    invoke-virtual {p0, v0}, Lcom/taobao/tao/log/godeye/core/b/a/a;->a(Ljava/lang/Class;)V

    return-void
.end method
