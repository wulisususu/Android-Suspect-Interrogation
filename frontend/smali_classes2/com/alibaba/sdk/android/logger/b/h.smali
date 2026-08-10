.class public Lcom/alibaba/sdk/android/logger/b/h;
.super Ljava/lang/Object;

# interfaces
.implements Lcom/alibaba/sdk/android/logger/interceptor/d;


# static fields
.field private static final a:[Ljava/lang/String;

.field private static final b:[Ljava/lang/String;


# instance fields
.field private c:Lcom/alibaba/sdk/android/logger/a/a;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    const-string v0, "null"

    filled-new-array {v0}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/logger/b/h;->a:[Ljava/lang/String;

    const-string v0, "[]"

    filled-new-array {v0}, [Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/logger/b/h;->b:[Ljava/lang/String;

    return-void
.end method

.method public constructor <init>(Lcom/alibaba/sdk/android/logger/a/a;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/alibaba/sdk/android/logger/b/h;->c:Lcom/alibaba/sdk/android/logger/a/a;

    return-void
.end method

.method private a([Ljava/lang/Object;)[Ljava/lang/String;
    .locals 4

    if-nez p1, :cond_0

    sget-object p1, Lcom/alibaba/sdk/android/logger/b/h;->a:[Ljava/lang/String;

    return-object p1

    :cond_0
    array-length v0, p1

    if-nez v0, :cond_1

    sget-object p1, Lcom/alibaba/sdk/android/logger/b/h;->b:[Ljava/lang/String;

    return-object p1

    :cond_1
    array-length v0, p1

    new-array v0, v0, [Ljava/lang/String;

    const/4 v1, 0x0

    :goto_0
    array-length v2, p1

    if-ge v1, v2, :cond_2

    iget-object v2, p0, Lcom/alibaba/sdk/android/logger/b/h;->c:Lcom/alibaba/sdk/android/logger/a/a;

    aget-object v3, p1, v1

    invoke-virtual {v2, v3}, Lcom/alibaba/sdk/android/logger/a/a;->a(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v2

    aput-object v2, v0, v1

    add-int/lit8 v1, v1, 0x1

    goto :goto_0

    :cond_2
    return-object v0
.end method

.method private a([Ljava/lang/String;)[Ljava/lang/String;
    .locals 11

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const/4 v2, 0x1

    const/4 v3, 0x0

    move v5, v2

    move v4, v3

    :goto_0
    array-length v6, p1

    if-ge v4, v6, :cond_6

    aget-object v6, p1, v4

    if-nez v6, :cond_0

    const-string v6, ""

    :cond_0
    if-nez v5, :cond_1

    const-string v7, " "

    invoke-virtual {v1, v7}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_1

    :cond_1
    move v5, v3

    :goto_1
    const-string v7, "\n"

    invoke-virtual {v6, v7}, Ljava/lang/String;->contains(Ljava/lang/CharSequence;)Z

    move-result v8

    if-eqz v8, :cond_4

    invoke-virtual {v6, v7}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object v8

    move v9, v3

    :goto_2
    array-length v10, v8

    if-ge v9, v10, :cond_5

    aget-object v10, v8, v9

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    array-length v10, v8

    sub-int/2addr v10, v2

    if-ge v9, v10, :cond_2

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    goto :goto_3

    :cond_2
    array-length v10, v8

    sub-int/2addr v10, v2

    if-ne v9, v10, :cond_3

    invoke-virtual {v6, v7}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v10

    if-eqz v10, :cond_3

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    move v5, v2

    :cond_3
    :goto_3
    add-int/lit8 v9, v9, 0x1

    goto :goto_2

    :cond_4
    invoke-virtual {v1, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    :cond_5
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_6
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->add(Ljava/lang/Object;)Z

    new-array p1, v3, [Ljava/lang/String;

    invoke-virtual {v0, p1}, Ljava/util/ArrayList;->toArray([Ljava/lang/Object;)[Ljava/lang/Object;

    move-result-object p1

    check-cast p1, [Ljava/lang/String;

    return-object p1
.end method


# virtual methods
.method public a(Lcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;[Ljava/lang/Object;Lcom/alibaba/sdk/android/logger/ILogger;)V
    .locals 2

    invoke-direct {p0, p3}, Lcom/alibaba/sdk/android/logger/b/h;->a([Ljava/lang/Object;)[Ljava/lang/String;

    move-result-object p3

    invoke-direct {p0, p3}, Lcom/alibaba/sdk/android/logger/b/h;->a([Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p3

    const/4 v0, 0x0

    :goto_0
    array-length v1, p3

    if-ge v0, v1, :cond_0

    aget-object v1, p3, v0

    invoke-interface {p4, p1, p2, v1}, Lcom/alibaba/sdk/android/logger/ILogger;->print(Lcom/alibaba/sdk/android/logger/LogLevel;Ljava/lang/String;Ljava/lang/String;)V

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_0
    return-void
.end method
