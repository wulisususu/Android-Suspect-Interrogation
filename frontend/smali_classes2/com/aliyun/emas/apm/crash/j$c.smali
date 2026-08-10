.class Lcom/aliyun/emas/apm/crash/j$c;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/android/gms/tasks/Continuation;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/crash/j;->a(Ljava/util/concurrent/Callable;)Lcom/google/android/gms/tasks/Continuation;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Ljava/util/concurrent/Callable;

.field final synthetic b:Lcom/aliyun/emas/apm/crash/j;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/crash/j;Ljava/util/concurrent/Callable;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/j$c;->b:Lcom/aliyun/emas/apm/crash/j;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/j$c;->a:Ljava/util/concurrent/Callable;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public then(Lcom/google/android/gms/tasks/Task;)Ljava/lang/Object;
    .locals 0

    iget-object p1, p0, Lcom/aliyun/emas/apm/crash/j$c;->a:Ljava/util/concurrent/Callable;

    .line 1
    invoke-interface {p1}, Ljava/util/concurrent/Callable;->call()Ljava/lang/Object;

    move-result-object p1

    return-object p1
.end method
