.class Lcom/aliyun/emas/apm/crash/l$d;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/l;->d()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/aliyun/emas/apm/crash/l;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/l;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/l$d;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/Boolean;
    .locals 3

    :try_start_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/l$d;->a:Lcom/aliyun/emas/apm/crash/l;

    .line 1
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/l;->a(Lcom/aliyun/emas/apm/crash/l;)Lcom/aliyun/emas/apm/crash/m;

    move-result-object v0

    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/m;->d()Z

    move-result v0

    if-nez v0, :cond_0

    .line 3
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v1

    const-string v2, "Initialization marker file was not properly removed."

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/Logger;->w(Ljava/lang/String;)V

    .line 5
    :cond_0
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    move-exception v0

    .line 7
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/Logger;->getLogger()Lcom/aliyun/emas/apm/crash/internal/Logger;

    move-result-object v1

    const-string v2, "Problem encountered deleting Crashlytics initialization marker."

    .line 8
    invoke-virtual {v1, v2, v0}, Lcom/aliyun/emas/apm/crash/internal/Logger;->e(Ljava/lang/String;Ljava/lang/Throwable;)V

    .line 9
    sget-object v0, Ljava/lang/Boolean;->FALSE:Ljava/lang/Boolean;

    return-object v0
.end method

.method public bridge synthetic call()Ljava/lang/Object;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/l$d;->a()Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method
