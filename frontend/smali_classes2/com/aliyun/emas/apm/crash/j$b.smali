.class Lcom/aliyun/emas/apm/crash/j$b;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/util/concurrent/Callable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/j;->a(Ljava/lang/Runnable;)Lcom/google/android/gms/tasks/Task;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/lang/Runnable;

.field final synthetic b:Lcom/aliyun/emas/apm/crash/j;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/j;Ljava/lang/Runnable;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/j$b;->b:Lcom/aliyun/emas/apm/crash/j;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/j$b;->a:Ljava/lang/Runnable;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a()Ljava/lang/Void;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/j$b;->a:Ljava/lang/Runnable;

    .line 1
    invoke-interface {v0}, Ljava/lang/Runnable;->run()V

    const/4 v0, 0x0

    return-object v0
.end method

.method public bridge synthetic call()Ljava/lang/Object;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/j$b;->a()Ljava/lang/Void;

    move-result-object v0

    return-object v0
.end method
