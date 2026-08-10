.class public Lcom/alibaba/sdk/android/tbrest/rest/b;
.super Ljava/lang/Object;
.source "RestKeyArraySorter.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/sdk/android/tbrest/rest/b$a;,
        Lcom/alibaba/sdk/android/tbrest/rest/b$b;
    }
.end annotation


# static fields
.field private static a:Lcom/alibaba/sdk/android/tbrest/rest/b;


# instance fields
.field private final a:Lcom/alibaba/sdk/android/tbrest/rest/b$a;

.field private final a:Lcom/alibaba/sdk/android/tbrest/rest/b$b;


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method private constructor <init>()V
    .locals 2

    .line 19
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 16
    new-instance v0, Lcom/alibaba/sdk/android/tbrest/rest/b$b;

    const/4 v1, 0x0

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/tbrest/rest/b$b;-><init>(Lcom/alibaba/sdk/android/tbrest/rest/b$1;)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/b;->a:Lcom/alibaba/sdk/android/tbrest/rest/b$b;

    .line 17
    new-instance v0, Lcom/alibaba/sdk/android/tbrest/rest/b$a;

    invoke-direct {v0, v1}, Lcom/alibaba/sdk/android/tbrest/rest/b$a;-><init>(Lcom/alibaba/sdk/android/tbrest/rest/b$1;)V

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/rest/b;->a:Lcom/alibaba/sdk/android/tbrest/rest/b$a;

    return-void
.end method

.method public static declared-synchronized a()Lcom/alibaba/sdk/android/tbrest/rest/b;
    .locals 2

    const-class v0, Lcom/alibaba/sdk/android/tbrest/rest/b;

    monitor-enter v0

    :try_start_0
    sget-object v1, Lcom/alibaba/sdk/android/tbrest/rest/b;->a:Lcom/alibaba/sdk/android/tbrest/rest/b;

    if-nez v1, :cond_0

    .line 24
    new-instance v1, Lcom/alibaba/sdk/android/tbrest/rest/b;

    invoke-direct {v1}, Lcom/alibaba/sdk/android/tbrest/rest/b;-><init>()V

    sput-object v1, Lcom/alibaba/sdk/android/tbrest/rest/b;->a:Lcom/alibaba/sdk/android/tbrest/rest/b;

    :cond_0
    sget-object v1, Lcom/alibaba/sdk/android/tbrest/rest/b;->a:Lcom/alibaba/sdk/android/tbrest/rest/b;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 26
    monitor-exit v0

    return-object v1

    :catchall_0
    move-exception v1

    monitor-exit v0

    throw v1
.end method


# virtual methods
.method public a([Ljava/lang/String;Z)[Ljava/lang/String;
    .locals 1

    if-eqz p2, :cond_0

    iget-object p2, p0, Lcom/alibaba/sdk/android/tbrest/rest/b;->a:Lcom/alibaba/sdk/android/tbrest/rest/b$a;

    goto :goto_0

    :cond_0
    iget-object p2, p0, Lcom/alibaba/sdk/android/tbrest/rest/b;->a:Lcom/alibaba/sdk/android/tbrest/rest/b$b;

    :goto_0
    if-eqz p1, :cond_1

    .line 37
    array-length v0, p1

    if-lez v0, :cond_1

    .line 38
    invoke-static {p1, p2}, Ljava/util/Arrays;->sort([Ljava/lang/Object;Ljava/util/Comparator;)V

    return-object p1

    :cond_1
    const/4 p1, 0x0

    return-object p1
.end method
