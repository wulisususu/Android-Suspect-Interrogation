.class public Lcom/aliyun/emas/apm/crash/v;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final b:Lcom/aliyun/emas/apm/crash/p;


# instance fields
.field private final a:Lcom/aliyun/emas/apm/crash/r0;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/p;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/p;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/crash/v;->b:Lcom/aliyun/emas/apm/crash/p;

    return-void
.end method

.method constructor <init>(Lcom/aliyun/emas/apm/crash/r0;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/v;->a:Lcom/aliyun/emas/apm/crash/r0;

    return-void
.end method

.method public static a(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/x0;Lcom/aliyun/emas/apm/crash/m0;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/ApmOptions;)Lcom/aliyun/emas/apm/crash/v;
    .locals 0

    .line 1
    new-instance p0, Lcom/aliyun/emas/apm/crash/r0;

    .line 2
    invoke-interface {p1}, Lcom/aliyun/emas/apm/crash/x0;->getSettingsSync()Lcom/aliyun/emas/apm/crash/v0;

    move-result-object p1

    invoke-direct {p0, p1, p2, p3, p4}, Lcom/aliyun/emas/apm/crash/r0;-><init>(Lcom/aliyun/emas/apm/crash/v0;Lcom/aliyun/emas/apm/crash/m0;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/ApmOptions;)V

    .line 3
    new-instance p1, Lcom/aliyun/emas/apm/crash/v;

    invoke-direct {p1, p0}, Lcom/aliyun/emas/apm/crash/v;-><init>(Lcom/aliyun/emas/apm/crash/r0;)V

    return-object p1
.end method


# virtual methods
.method public a(Lcom/aliyun/emas/apm/crash/q;Z)Lcom/google/android/gms/tasks/Task;
    .locals 1

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/v;->a:Lcom/aliyun/emas/apm/crash/r0;

    .line 4
    invoke-virtual {v0, p1, p2}, Lcom/aliyun/emas/apm/crash/r0;->a(Lcom/aliyun/emas/apm/crash/q;Z)Lcom/google/android/gms/tasks/TaskCompletionSource;

    move-result-object p1

    invoke-virtual {p1}, Lcom/google/android/gms/tasks/TaskCompletionSource;->getTask()Lcom/google/android/gms/tasks/Task;

    move-result-object p1

    return-object p1
.end method
