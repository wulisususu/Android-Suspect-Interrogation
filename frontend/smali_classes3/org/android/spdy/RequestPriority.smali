.class public final enum Lorg/android/spdy/RequestPriority;
.super Ljava/lang/Enum;
.source "RequestPriority.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lorg/android/spdy/RequestPriority;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lorg/android/spdy/RequestPriority;

.field public static final enum DEFAULT_PRIORITY:Lorg/android/spdy/RequestPriority;

.field public static final enum HIGH:Lorg/android/spdy/RequestPriority;

.field public static final enum HIGHEST:Lorg/android/spdy/RequestPriority;

.field public static final enum IDLE:Lorg/android/spdy/RequestPriority;

.field public static final enum LOW:Lorg/android/spdy/RequestPriority;

.field public static final enum LOWEST:Lorg/android/spdy/RequestPriority;

.field public static final enum MEDIUM:Lorg/android/spdy/RequestPriority;


# instance fields
.field private priority:I


# direct methods
.method static constructor <clinit>()V
    .locals 10

    .line 10
    new-instance v0, Lorg/android/spdy/RequestPriority;

    const-string v1, "HIGHEST"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lorg/android/spdy/RequestPriority;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lorg/android/spdy/RequestPriority;->HIGHEST:Lorg/android/spdy/RequestPriority;

    .line 14
    new-instance v1, Lorg/android/spdy/RequestPriority;

    const-string v2, "HIGH"

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3, v3}, Lorg/android/spdy/RequestPriority;-><init>(Ljava/lang/String;II)V

    sput-object v1, Lorg/android/spdy/RequestPriority;->HIGH:Lorg/android/spdy/RequestPriority;

    .line 18
    new-instance v2, Lorg/android/spdy/RequestPriority;

    const-string v4, "MEDIUM"

    const/4 v5, 0x2

    invoke-direct {v2, v4, v5, v5}, Lorg/android/spdy/RequestPriority;-><init>(Ljava/lang/String;II)V

    sput-object v2, Lorg/android/spdy/RequestPriority;->MEDIUM:Lorg/android/spdy/RequestPriority;

    .line 22
    new-instance v4, Lorg/android/spdy/RequestPriority;

    const-string v5, "LOW"

    const/4 v6, 0x3

    invoke-direct {v4, v5, v6, v6}, Lorg/android/spdy/RequestPriority;-><init>(Ljava/lang/String;II)V

    sput-object v4, Lorg/android/spdy/RequestPriority;->LOW:Lorg/android/spdy/RequestPriority;

    .line 26
    new-instance v5, Lorg/android/spdy/RequestPriority;

    const-string v6, "LOWEST"

    const/4 v7, 0x4

    invoke-direct {v5, v6, v7, v7}, Lorg/android/spdy/RequestPriority;-><init>(Ljava/lang/String;II)V

    sput-object v5, Lorg/android/spdy/RequestPriority;->LOWEST:Lorg/android/spdy/RequestPriority;

    .line 30
    new-instance v6, Lorg/android/spdy/RequestPriority;

    const-string v7, "IDLE"

    const/4 v8, 0x5

    invoke-direct {v6, v7, v8, v8}, Lorg/android/spdy/RequestPriority;-><init>(Ljava/lang/String;II)V

    sput-object v6, Lorg/android/spdy/RequestPriority;->IDLE:Lorg/android/spdy/RequestPriority;

    .line 32
    new-instance v7, Lorg/android/spdy/RequestPriority;

    const-string v8, "DEFAULT_PRIORITY"

    const/4 v9, 0x6

    invoke-direct {v7, v8, v9, v3}, Lorg/android/spdy/RequestPriority;-><init>(Ljava/lang/String;II)V

    sput-object v7, Lorg/android/spdy/RequestPriority;->DEFAULT_PRIORITY:Lorg/android/spdy/RequestPriority;

    move-object v3, v4

    move-object v4, v5

    move-object v5, v6

    move-object v6, v7

    filled-new-array/range {v0 .. v6}, [Lorg/android/spdy/RequestPriority;

    move-result-object v0

    sput-object v0, Lorg/android/spdy/RequestPriority;->$VALUES:[Lorg/android/spdy/RequestPriority;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I)V"
        }
    .end annotation

    .line 36
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lorg/android/spdy/RequestPriority;->priority:I

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lorg/android/spdy/RequestPriority;
    .locals 1

    const-class v0, Lorg/android/spdy/RequestPriority;

    .line 5
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lorg/android/spdy/RequestPriority;

    return-object p0
.end method

.method public static values()[Lorg/android/spdy/RequestPriority;
    .locals 1

    sget-object v0, Lorg/android/spdy/RequestPriority;->$VALUES:[Lorg/android/spdy/RequestPriority;

    .line 5
    invoke-virtual {v0}, [Lorg/android/spdy/RequestPriority;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lorg/android/spdy/RequestPriority;

    return-object v0
.end method


# virtual methods
.method getPriorityInt()I
    .locals 1

    iget v0, p0, Lorg/android/spdy/RequestPriority;->priority:I

    return v0
.end method
